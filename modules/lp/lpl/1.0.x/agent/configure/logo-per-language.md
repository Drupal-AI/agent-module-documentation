<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set a logo per language

The module has **no admin page, no config entity and no config schema of its own**. It works
entirely by altering the core **theme settings** form and storing extra values as theme settings.

## Where

Theme settings for the theme in question: **Appearance → Settings → *Theme name*** —
`admin/appearance/settings/{theme}`. `lpl_form_system_theme_settings_alter()`
(`lpl.module:15`) clones core's **Logo** section once per language, titled `Logo - {Language name}`.

## Which languages appear

Only languages that have a **non-empty URL prefix** in `language.negotiation` `url.prefixes` get a
logo section (`lpl.module:17,21`). A monolingual site, or a language whose prefix is blank, gets no
extra field and no logo swap. The module declares **no dependency** on `language` /
`content_translation`, so on a single-language site it is inert.

## Stored settings (per language `{key}` = langcode)

Saved into the theme's settings config (`{theme}.settings`), read back with `theme_get_setting()`:

| Setting key | Form control | Meaning |
|---|---|---|
| `lpl_default_logo_{key}` | "Use the logo supplied by the theme" checkbox | `1` = leave this language on the theme default (module does nothing); `0` = use the custom values below |
| `lpl_{key}_logo_path` | "Path to custom logo" textfield | Path relative to Drupal root or public files, or a stream URI |
| `lpl_{key}_logo_upload` | "Upload logo image" file field | Managed-file id array of an uploaded logo |

- Upload target: `{default_scheme}://theme/logo_per_language/` (`lpl.module:48`,
  `default_scheme` from `system.file`).
- Allowed upload extensions: `gif png jpg jpeg svg` (`lpl.module:44`).
- The custom-path/upload fields are hidden (`#states` invisible) while the default-logo box is
  checked (`lpl.module:50`).

## Validation

On submit, `lpl_validate()` (`lpl.module:69`) checks each `lpl_{key}_logo_path` with
`lpl_validate_path()` (`lpl.module:101`) — the same rules core uses for its own logo path:
absolute local paths are rejected, otherwise the path must resolve to an existing file directly or
under `public://`. An invalid path raises "The custom logo path is invalid."

## How it renders

`lpl_preprocess_block()` (`lpl.module:123`) runs for the core **`system_branding_block`**:

1. Adds the `languages:language_interface` cache context so the block varies per interface language.
2. For the current language, if it has a URL prefix and `lpl_default_logo_{langcode}` is `0`:
   - a non-empty `lpl_{langcode}_logo_path` overrides the branding block's `site_logo` `#uri`
     (prefixed with `/`); otherwise
   - a `lpl_{langcode}_logo_upload` file id loads the managed file and uses its
     `createFileUrl()`.

So the swap only affects the standard branding block. A theme that prints the logo some other way
(custom template not using `system_branding_block`) is not affected.
