<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Highlight Js

**Settings form:** `/admin/config/content/highlight-js` (`HighlightJsSettingsForm`)
**Route:** `highlight_js.settings` (matches `configure:` in `highlight_js.info.yml`)
**Permission:** `administer highlight_js configuration` (`restrict access: TRUE`)
**Config object:** `highlight_js.settings` (schema in `config/schema/highligh_js.settings.schema.yml`)

## Config keys

| Key | Type | Install default | Meaning |
|---|---|---|---|
| `languages` | map (checkboxes) | `{}` | Languages offered in the CKEditor dialog's "Choose a language" select. Empty ⇒ dialog falls back to `c, css, java, javascript, markup, php`. Options come from `highlight_js_available_languages()` (240+). **Required** on the form. |
| `theme` | string | `github` | Default Highlight.js theme; attaches library `highlight_js.style-<theme>`. Options from `highlight_js_available_themes()` (380+). **Required**. (The filter's own fallback when the key is unset is `3024`.) |
| `copy_enable` | boolean | `true` | Master switch for the copy-to-clipboard button. |
| `copy_bg_transparent` | boolean | `false` | Transparent copy-button background. |
| `copy_bg_color` | string (color) | `#4243b1` | Copy-button background color. |
| `copy_txt_color` | string (color) | `#ffffff` | Copy-button text color. |
| `copy_btn_text` | label | `''` | Copy-button label (empty ⇒ JS default `Copy`). |
| `success_bg_transparent` | boolean | `false` | Transparent "copied" message background. |
| `success_bg_color` | string (color) | `#4243b1` | "Copied" message background color. |
| `success_txt_color` | string (color) | `#ffffff` | "Copied" message text color. |
| `copy_success_text` | label | `''` | "Copied" message text (empty ⇒ JS default `Copied!`). |
| `role_copy_access` | map (checkboxes) | `{}` | Roles allowed to see the copy button. Empty ⇒ everyone (when `copy_enable`). |

Install defaults live in `config/install/highlight_js.settings.yml`.

## Per-block overrides (from the editor dialog)
When `copy_enable` is on, the insert dialog (`HighlightJsDialogForm`) also exposes
**`role_based_copy`** (checkbox) and a per-block **`role_copy_access`** role list, stored inside the
block's `data-plugin-config` JSON. At render time the filter shows the copy button only if the
current user has one of the allowed roles (global list first, then the per-block list).

## Set it with Drush

```bash
drush cget highlight_js.settings
drush cget highlight_js.settings theme

# Pick a theme and restrict the language list (map values are 'key: key').
drush cset highlight_js.settings theme github-dark -y
drush cset highlight_js.settings copy_enable true -y
drush cr   # the form itself notes: flush caches for changes to take effect
```

## Notes
- The form prints "Flush all caches after the configuration changes to take effect" — filtered text
  and the attached theme library are cached, so run `drush cr` after changes.
- `languages` and `role_copy_access` use schema type `ignore` with a `NotNull` constraint (they are
  free-form maps of checkbox values, not typed sequences).
- The permission gating the form is `restrict access: TRUE`, so it is not granted by "administer
  filters" or any content-editor permission — it must be assigned explicitly.
