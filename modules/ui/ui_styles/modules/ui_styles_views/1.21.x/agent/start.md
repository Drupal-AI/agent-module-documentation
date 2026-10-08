<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Styles Views — agent index

Adds a Views **display extender** (`ui_styles`) that applies UI Styles classes to three view
parts: the **exposed form**, the **rows/style**, and the **pager**. No route/permission/settings
form; the extender is registered site-wide in `views.settings` at install.

- **Display extender registration, the three sections, config path, and rendering** →
  [configure/views-styles.md](configure/views-styles.md)

Key facts:
- Extender id `ui_styles` (`Plugin\views\display_extender\Styles`); install adds it to
  `views.settings` → `display_extenders`.
- Per-display config: `display_options.display_extenders.ui_styles.{exposed_form_options,
  style_options, pager_options}`, each a `ui_styles.selected_mapping` `{selected, extra}`.
- `preprocess_views_view` injects classes onto `exposed` / `rows` / `pager` via
  `StylePluginManager::addClasses()`. Pager section only applies when a pager is enabled.
