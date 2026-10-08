<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Modules Weight — agent index

UI + Drush to change modules' **weight** (hook execution order). Weights live in
`core.extension`'s `module` map (applied via core `module_set_weight()`). Requires the
`administer modules weight` permission. No plugins, no external deps.

- **Reorder UI, the `show_system_modules` setting, routes, where weights are stored** →
  [configure/reorder.md](configure/reorder.md)
- **Drush commands (`mw-list`, `mw-reorder`, `mw-show-system-modules`)** →
  [drush/commands.md](drush/commands.md)
- **The `modules_weight` service (`getModulesList()`)** → [api/service.md](api/service.md)

Key facts:
- Config: `modules_weight.settings` → `show_system_modules` (bool, default `FALSE`) — whether
  Core modules are shown/reorderable.
- Routes: `modules_weight.list_page` (`/admin/config/system/modules-weight`, the reorder form),
  `modules_weight.modules_weight_admin_settings` (`/…/configuration`, the configure route).
- A module's weight is `core.extension` → `module.<machine_name>`; lower runs earlier.
