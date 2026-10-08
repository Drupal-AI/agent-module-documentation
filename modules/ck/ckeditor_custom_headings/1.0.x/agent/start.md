<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Custom Headings (ckeditor_custom_headings) — agent index

Lets a site builder define **custom heading options** for CKEditor 5's Heading dropdown, per text
format — additional entries beyond the standard H2–H6, each a tag plus an optional CSS class and a
friendly label (e.g. `h2.custom-heading-2|Custom heading (h2)` → an `<h2 class="custom-heading-2">`
option). It does this by **subclassing core's own `ckeditor5_heading` plugin** and swapping the class
in via a plugin-info alter hook. No routes, no services, no permissions, no JS, no library, no config
files of its own — pure PHP configuration surface layered onto the core Heading plugin.

- **Depends on:** core `ckeditor5` only (`.info.yml`). No Composer requirements, no PHP library.
- **Core:** `^9.4 || ^10 || ^11`. **Version:** 1.0.0 (version dir `1.0.x`). **License:** GPL-2.0-or-later.
- **Config surface:** per-text-format, under *CKEditor 5 plugin settings → Headings*. No admin menu route
  (`configure: null`). Configuration is stored inside the existing `ckeditor5.plugin.ckeditor5_heading`
  plugin config on each editor.
- Based on the `rgpublic/ckeditor_custom_heading` GitHub project (README).

## Files (the whole module)

- `ckeditor_custom_headings.info.yml` — declares the module, `dependencies: drupal:ckeditor5`.
- `ckeditor_custom_headings.module` — two hooks (below). No other `.module` logic.
- `src/Plugin/CKEditor5Plugin/Heading.php` — the plugin class, extends core
  `Drupal\ckeditor5\Plugin\CKEditor5Plugin\Heading`.
- `README.md`, `LICENSE.txt`, `logo.png`, `logo.svg`. No `*.routing.yml`, `*.services.yml`,
  `*.permissions.yml`, `*.libraries.yml`, `js/`, `config/`, `templates/`, install/update hooks.

## How it hooks into core (`.module`)

- **`hook_ckeditor5_plugin_info_alter()`** — takes the existing `ckeditor5_heading` plugin definition,
  rewrites `drupal.class` to this module's `Heading::class`, and appends `<h1 class>` … `<h6 class>` to
  the plugin's declared `elements` (so the class attribute *can* be produced on any heading). Returns
  early if `ckeditor5_heading` is not registered.
- **`hook_config_schema_info_alter()`** — adds two keys to
  `ckeditor5.plugin.ckeditor5_heading` config schema: `customize` (boolean) and `custom_headings`
  (string). Also **removes the `NotBlank` constraint** on `enabled_headings` (so the format can be saved
  with no standard headings enabled when using custom ones) and repoints the `enabled_headings` `Choice`
  callback to `Heading::validChoices` (avoids an `AssertionError` from the swapped plugin class).

## The plugin class (`Heading.php`)

Extends core Heading; the interesting overrides:

- **`defaultConfiguration()`** — adds `customize => FALSE`, `custom_headings => ''`.
- **`buildConfigurationForm()`** — adds a **Customize headings** checkbox and a **Custom Headings**
  textarea to the core form. When *customize* is on, the core `enabled_headings` control is hidden
  (`#access = FALSE`) and the textarea shown, and vice-versa.
- **`submitConfigurationForm()`** — persists `customize` and `custom_headings` into plugin config.
- **`getDynamicPluginConfig()`** — when `custom_headings` is empty, defers entirely to the parent
  (standard behaviour). Otherwise parses the textarea and builds the CKEditor `heading.options` array:
  each line → `{ model, view, title, class, converterPriority }`. Sets `model` from the tag
  (`paragraph` for `p`, `heading1`..`heading6` for `h1`..`h6`, suffixed with the ucfirst'd class);
  when a class is present, `view` becomes `{name, classes}` and `converterPriority` is `high`.
- **`getElementsSubset()`** — when custom, returns only the `<hN>` (and `<hN class>` where a class was
  configured) tags that intersect the plugin's declared elements. So the widened `<hN class>` allowance
  is scoped to the heading tags the admin actually configured a class for; empty custom = parent subset.
- **`parseConfiguration()`** — splits the textarea on newlines; each non-empty line matched against
  `^(?<tag>[^|.]*)(?:\.(?<class>[^|]*))?(?:\|(?<title>.*))?$` → tag / optional `.class` / optional
  `|title`. Non-matching lines are skipped.
- **`getModelFromItem()`** — maps tag→model; **throws `\RuntimeException`** for any tag other than `p`
  or `h1`–`h6`. Note this makes a mis-typed tag (e.g. `div.foo`) fatal at editor-render time rather than
  a validation error — a robustness caveat for site builders, not a security issue.

## Config format (admin-entered, one per line)

```
h2.custom-heading-2|Custom heading (h2)
```
`tag` (required, `p` or `h1`–`h6`) `.class` (optional CSS class) `|title` (optional dropdown label).

## Security / trust model

Configuration is **admin-only** (editing a text format requires *administer filters*). The
`custom_headings` string is site-builder input, not end-editor free text; it is parsed into CKEditor
plugin config, never executed, never written into rendered attributes on the server. The module widens
the allowed HTML for headings to include the **`class`** attribute (scoped by `getElementsSubset()` to
configured tags) — `class` only, no `style`, no `attributes: true`. No routes, uploads, DB queries, or
outbound requests. See `usage.md` and `human-docs/` for setup guidance.
