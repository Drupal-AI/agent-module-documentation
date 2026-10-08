<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Bootstrap Buttons (c5bb) — agent index

One CKEditor 5 plugin that adds a **Bootstrap Buttons** (`BButton`) toolbar item for inserting
class-styled button links. Configured per text format (no module `configure` route,
`configure` = null). Depends on core `ckeditor5`. No permissions, no Drush. Ships a config schema.

- **Enable the toolbar button on a format, the three settings (Class Selectors syntax, Text Class,
  Show Icon Settings), defaults, and how config reaches the JS** → [configure/editor.md](configure/editor.md)

Key facts:
- CKEditor5 plugin id `c5bb_bbutton`, JS plugin `bbutton.BButton`, class
  `Drupal\c5bb\Plugin\CKEditor5Plugin\C5BB` (implements `CKEditor5PluginConfigurableInterface`,
  `CKEditor5PluginElementsSubsetInterface`).
- Config schema `ckeditor5.plugin.c5bb_bbutton`: `classes` (string, textarea), `textClass` (string),
  `showIconSettings` (integer 0/1). Stored inside the editor entity's settings.
- Declared elements: `<a>`, `<a class href target>`, `<em class>`, `<span class>`.
- No Bootstrap CSS is shipped — only editor stylesheet `css/cke5.css` (via `ckeditor5-stylesheets`
  + `hook_css_alter`) and `css/admin-styles.css`; the theme must supply front-end button CSS.
