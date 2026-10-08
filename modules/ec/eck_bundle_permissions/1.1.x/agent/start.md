<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECK Bundle Permissions (eck_bundle_permissions) — agent index

Adds **per-bundle** create/edit/delete/view permissions to Entity Construction Kit (ECK) entities.
ECK's own permissions are per entity **type** (`edit any event entities` covers every bundle); this
module generates the finer per-(type×bundle) permissions and a matching access handler so a role can
be granted rights on one ECK bundle without all of them. Depends on `eck`. Core `^8 || ^9 || ^10 || ^11`.
No settings page (`configure` = null), no routes/forms/drush/plugins of its own — five files.

- **The per-bundle permissions it generates, their machine names, and how to grant them** →
  [permissions/permissions.md](permissions/permissions.md)
- **How it wires in: `hook_entity_type_alter`, the access handler, the per-bundle permissions tab** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- **Permissions are GENERATED, not declared.** `eck_bundle_permissions.permissions.yml` holds only a
  `permission_callbacks:` entry pointing at
  `\Drupal\eck_bundle_permissions\EckBundlePermissionsGenerator::entityPermissions`. Grepping YAML
  finds nothing — read the class.
- Machine names (per eck entity type `{type}` × bundle `{bundle}`):
  `create {type} entities of bundle {bundle}`,
  `edit any {type} entities of bundle {bundle}`, `delete any … `, `view any … `, and — only for eck
  entity types that have an author field — `edit own … `, `delete own … `, `view own … `.
- Enforcement: `EckBundleAccessControlHandler` (extends eck's `EckEntityAccessControlHandler`),
  installed on every eck entity type by `eck_bundle_permissions_entity_type_alter()` via
  `setAccessClass()`. It **OR**s the per-bundle permission onto eck's per-type result — it only ever
  adds access, never removes it.
- Per-bundle permissions UI: `hook_entity_type_alter` also gives each bundle its own permissions tab
  at `/admin/structure/eck/entity/{type}/bundles/{bundle}/permissions` (core
  `EntityPermissionsRouteProvider`, Drupal ≥ 10.3).
- New ECK bundles are **closed by default**: their new permissions are held by no role until granted.
