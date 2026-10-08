<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AT Tool — agent index

Module-side helper for the **Adaptivetheme** (AT) theme system on Drupal 10/11. Thin: a few
theme hooks + one lazy-builder service. No config UI (`configure: null`), no config entities, no
permissions, no routes, no Drush. Behavior is driven by the **active Adaptivetheme sub-theme's**
theme settings. Requires the `drupal/adaptivetheme` theme (Composer).

- **What it does at the theme layer (livereload, layout CSS, appearance page) + the theme
  settings it reads** → [configure/theme-support.md](configure/theme-support.md)
- **The `at_tool.lazy_builders` breadcrumb-title lazy builder** →
  [api/lazy-builders.md](api/lazy-builders.md)

Key facts:
- No settings of its own; it reads the **active theme's** config `<theme>.settings` → `settings`
  keys: `enable_devel`, `enable_live_reload`, `live_reload_port` (default `35729`),
  `layouts_enable`.
- Hooks: `hook_preprocess_system_themes_page` (Appearance page CSS + per-theme classes),
  `hook_library_info_alter` (livereload + layout-settings CSS).
- Service `at_tool.lazy_builders` (`AtToolLazyBuilders`, `TrustedCallbackInterface`) →
  `breadcrumbTitle()` returns a `#theme => page_title__breadcrumb` render array.
- The project also ships **starterkit themes** (AT SKIN / STARTERKIT / AT Theme Generator) —
  these are themes, not modules; do not enable them as modules.
