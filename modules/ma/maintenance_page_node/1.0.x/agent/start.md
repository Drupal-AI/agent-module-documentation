<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maintenance Page Node (maintenance_page_node) — agent index

**Renders a chosen node on the maintenance-mode page instead of the default offline message.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Package:** Administration
- **UI:** no new route — `RouteSubscriber` swaps `system.site_maintenance_mode` (`/admin/config/development/maintenance`, `administer site configuration`) to `MaintenanceNodeForm`
- **Config:** `maintenance.node:maintenance_node` (node id)
- **Render:** `hook_theme_registry_alter` + `hook_preprocess_maintenance_page` render the node with the `master` view mode into `{{ maintenance_node }}`

**Security:** no anonymous or mutating endpoints; the node selection is written only through core's maintenance-mode form under `administer site configuration`.

See [configure/settings.md](configure/settings.md)
