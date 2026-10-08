<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nodeaccess — agent index

Per-node and per-content-type **view / edit / delete** access via Drupal's node grant system.
Two layers: content-type **defaults** in the `nodeaccess.settings` config object, and per-node
overrides on each node's **Grants** tab (stored in the module's own `nodeaccess` DB table).
Configure route: `nodeaccess.administration`. No Drush. No plugins.

- **Global settings: config model, the settings form, per-bundle role grants & availability** →
  [configure/settings.md](configure/settings.md)
- **Runtime grant mechanics: realms, the hooks, the `nodeaccess` table, per-node Grants tab** →
  [api/grants.md](api/grants.md)
- **Permissions (incl. the dynamic per-content-type grant permission)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `nodeaccess.settings`; per-type defaults at
  `bundles_roles_grants.<bundle>.<role|author>.{grant_view,grant_update,grant_delete}` (0/1).
- Realms: `nodeaccess_role`, `nodeaccess_user`, `nodeaccess_author`; `map_rid_gid` maps role id → numeric grant id.
- Per-node grants live in the `nodeaccess` table and OVERRIDE the bundle defaults for that node.
- Changing grants calls `node_access_needs_rebuild(TRUE)`.
