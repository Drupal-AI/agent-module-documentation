<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Maintenance Page Node lets you select a node whose content is rendered on the maintenance-mode page in place of Drupal's default offline message.

---

A route subscriber replaces the form on core's maintenance-mode route (`system.site_maintenance_mode`) with `MaintenanceNodeForm`, which extends core's `SiteMaintenanceModeForm` and adds a single entity-autocomplete for a node. The chosen node id is stored in config `maintenance.node:maintenance_node`; leaving it empty keeps Drupal's default message.

At render time the module repoints the `maintenance_page` theme hook to its own template via `hook_theme_registry_alter`, and `hook_preprocess_maintenance_page` loads the selected node and renders it with the `master` view mode, passing the markup to the template as `maintenance_node`. This means you control the offline page's look through normal node editing and view-mode configuration rather than by editing templates. Setup is: enable the module, create the node you want shown, and select it on the maintenance-mode settings page (guarded by core's `administer site configuration`).

---

- Show a branded node on the maintenance page during downtime
- Replace the default "site under maintenance" text with real content
- Pick the maintenance node from the maintenance-mode settings page
- Fall back to the core message by leaving the node empty
- Style the offline page by configuring the node's `master` view mode
- Announce planned downtime with a rich content node
- Include images/markup on the maintenance page via node fields
- Reuse an existing node as the maintenance page
- Swap the maintenance node without code changes
- Provide contact details or status info while the site is offline
- Keep the maintenance page editable by content authors
- Localize the maintenance page by translating the node
- Control access to the setting via `administer site configuration`
- Review the configured node id under `maintenance.node`
- Combine with scheduled maintenance windows
- Present a temporary landing page during deployments
