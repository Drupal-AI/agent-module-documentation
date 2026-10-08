<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSS Editor — agent index

Adds a **Custom CSS** fieldset to core's theme settings form. No route of its own, no
permissions, no plugins, `configure: null`. One config object **per theme** plus one generated
file in the public files directory.

- **Where the CSS lives, the config keys, and how to set it from drush/PHP** →
  [configure/custom-css.md](configure/custom-css.md)
- **The generator service, the two delivery hooks, the theme negotiator** →
  [api/css-generator.md](api/css-generator.md)

Key facts:
- Config object: `css_editor.theme.<theme_machine_name>` with keys
  `enabled` (bool), `css` (text), `plaintext_enabled` (bool), `autopreview_enabled` (bool),
  `path` (written by the module).
- Generated file: `public://css_editor/<theme>.css`.
- Service: `css_editor.css_generator` → `Drupal\css_editor\CssEditorService`
  (`generateCssFile($theme)`, `regenerateAllCssFiles()`).
- UI: `/admin/appearance/settings/<theme>` (core route `system_theme_settings`), altered by
  `css_editor_form_system_theme_settings_alter()`.
- CSS is attached only when `enabled` is TRUE **and** the file at `path` exists.
- `hook_cache_flush()` regenerates every theme's file — the config is the source of truth.
- Libraries: `css_editor/css_editor` (own JS/CSS) and `css_editor/codemirror`
  (CodeMirror 5.31.0 from cdnjs — external, needs outbound network).
