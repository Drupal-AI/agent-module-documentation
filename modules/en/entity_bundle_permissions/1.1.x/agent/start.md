# Entity Bundle Permissions — agent index

Generates one permission per content-entity bundle (`entity_bundle_permissions access <entity_type> <bundle>`)
and, via `hook_entity_access()`, **forbids all operations** on an entity whose bundle the user
lacks that permission for. The permission is purely restrictive — it never grants access, only
removes it from those who don't hold it. One settings config, one admin permission, no plugins,
no Drush.

- **Config UI, the `ignored_entity_types` setting, drush config** →
  [configure/settings.md](configure/settings.md)
- **The generated per-bundle permissions + the `administer` permission, and how they gate access** →
  [permissions/permissions.md](permissions/permissions.md)
- **Mechanism: `DynamicPermissions::applies()`/`get()` and the access hook** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Configure route `entity_bundle_permissions.settings` → `/admin/config/entity-bundle-permissions`.
- Admin permission `administer entity_bundle_permissions`.
- Permission id pattern: `entity_bundle_permissions access {entity_type_id} {bundle_id}`.
- Config object `entity_bundle_permissions.settings` with one key `ignored_entity_types` (sequence).
