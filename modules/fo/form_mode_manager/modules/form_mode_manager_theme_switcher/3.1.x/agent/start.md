<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form Mode Manager Theme Switcher — agent index

Assigns a theme per Form Mode Manager form-mode route via a theme negotiator. Requires the parent
`form_mode_manager` module and core `field`.

- **The settings, config keys, form-mode id format, and theme resolution** →
  [configure/theme-switcher.md](configure/theme-switcher.md)

Key facts:
- Configure route: `form_mode_manager.theme_switcher_settings` =
  `/admin/config/content/form_mode_manager/theme-switcher` (permission `administer site configuration`).
- Config object: `form_mode_manager_theme_switcher.settings` with `type.<form_mode_id>` (the theme
  kind) and `form_mode.<form_mode_id>` (the specific theme name when type is `_custom`).
- `<form_mode_id>` = the route's `_entity_form` operation with dots → underscores, e.g.
  `node.contributor` → `node_contributor`.
- Theme negotiator: `theme.negotiator.form_mode_theme_switcher` (priority -30); applies only on
  routes that carry the `_form_mode_manager_entity_type_id` option.
- `type` values: `admin` (admin theme, needs `view the administration theme`), a system theme key
  (e.g. `default`), or `_custom` (use the theme named in `form_mode.<form_mode_id>`).
