# Entity Limit — agent index

Caps how many entities a user may create, per role or per user, enforced via
`hook_entity_create_access()`. Config entity `entity_limit`; pluggable limit conditions. No Drush.
Provides a config schema and permissions.

- **The `entity_limit` config entity, admin routes/UI, Role vs User limits, weight/priority resolution** →
  [configure/limits.md](configure/limits.md)
- **The `entity_limit` plugin type (annotation, interface) and how to add a custom condition** →
  [plugins/entity-limit.md](plugins/entity-limit.md)

Key facts:
- Config UI: `entity.entity_limit.collection` = `/admin/structure/entity_limit` (add/edit/delete/manage),
  all gated by `administer entity limit`. Second permission `manage entity limits` is defined but unused by routes.
- Config entity `entity_limit` fields: `id`, `label`, `weight`, `plugin`, `entity_type`, `entity_bundles[]`,
  `limits[]` (`{id, limit}`), `uuid`. `admin_permission = administer entity limit`.
- Ships plugins: `role_limit` (priority 1) and `user_limit` (priority 0). `-1` = unlimited; admin role/users
  are always exempt.
- Enforcement service `entity_limit.inspector` (`EntityLimitInspector`): sorts applicable limits by config
  weight then plugin priority, then the winning plugin's `checkAccess()` counts the user's owned entities of
  the target bundles (entity query on owner+bundle keys, `accessCheck(FALSE)`) and forbids when count ≥ limit.
- This is an access-restricting module (it only ever tightens create access).
