<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling & configuring the Pullquote button

## Install / enable
```bash
composer require drupal/ckeditor5_pullquote   # only needs core; require is drupal/core ^10.5||^11
drush en ckeditor5_pullquote
```
Requires core's `ckeditor5` module (info.yml `dependencies: drupal:ckeditor5`).

## Add the button to a text format
There is **no dedicated admin route** (`configure: null`). Configuration lives inside each text format:
1. Configuration → Content authoring → Text formats and editors (`/admin/config/content/formats`).
2. Edit a format that uses the CKEditor 5 editor.
3. Drag the **Pullquote** button into the active toolbar.

Adding the button auto-registers the required tags into the format's filter allowlist (from `ckeditor5_pullquote.ckeditor5.yml` `elements`):
`<pullquote>`, `<pullquote class>`, `<cite>`, `<pulledquote>`, `<pulledquote class role>`.
The text format's `filter_html` (if enabled) is the output boundary — only these tags/attributes (`class`, `role`) are permitted; no `style` or event attributes are allowed by the plugin.

## Style variants (per-format plugin settings)
The plugin is configurable (`Pullquote` implements `CKEditor5PluginConfigurableInterface`). In the format's editor settings, the Pullquote plugin exposes a single **Style variants** textarea (`Pullquote::buildConfigurationForm`), one entry per line:
```
box|Box with bg
line|Thick line on top
```
- `Pullquote::validateConfigurationForm()` rejects any non-empty line missing a `|`.
- `Pullquote::submitConfigurationForm()` splits each line on the first `|`, trims both halves, and keeps only lines where both `class` and `label` are non-empty, storing `variants` as `[{class, label}, ...]`.
- `Pullquote::getDynamicPluginConfig()` passes `{pullquote: {variants: [...]}}` to the JS plugin, which renders the variants as extra dropdown items.

## Config object & schema
- Stored inside the editor entity's `settings.plugins.ckeditor5_pullquote_pullquote`.
- `defaultConfiguration()` → `['variants' => []]`.
- Schema `config/schema/ckeditor5_pullquote.schema.yml` → `ckeditor5.plugin.ckeditor5_pullquote_pullquote`: a `variants` **sequence** of mappings `{class: string, label: string}`.

## Theming
`hook_page_attachments()` attaches `ckeditor5_pullquote/frontend` (which pulls `css/pullquote.css` + `js/behavior/pullquote.js`) on **every** page. Override `css/pullquote.css` in your theme to control `pulledquote` float width/typography and add a rule per variant `class`.
