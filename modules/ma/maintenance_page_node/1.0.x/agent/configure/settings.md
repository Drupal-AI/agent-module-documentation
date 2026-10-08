<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maintenance Page Node — configure (maintenance_page_node)

There is **no new route**. A `RouteSubscriber` swaps the form on core's maintenance-mode
route (`system.site_maintenance_mode`, `/admin/config/development/maintenance`,
permission `administer site configuration`) for `MaintenanceNodeForm`.

## What it adds
`MaintenanceNodeForm` extends core's `SiteMaintenanceModeForm` and adds a single
**Maintenance Node** `entity_autocomplete` (target `node`). The selected node id is saved
to config `maintenance.node:maintenance_node`. Leave it empty to fall back to core's
default maintenance message.

## How the node is rendered
- `hook_theme_registry_alter` repoints the `maintenance_page` template to this module's
  `templates/maintenance-page.html.twig`.
- `hook_preprocess_maintenance_page` loads the configured node and renders it with the
  **`master`** view mode, exposing it to the template as `{{ maintenance_node }}`.

## Setup
1. Enable the module.
2. Create/choose a node to show during downtime.
3. *Configuration → Development → Maintenance mode*, pick the node in **Maintenance Node**,
   save; optionally define a `master` view mode for that node type for full control.
