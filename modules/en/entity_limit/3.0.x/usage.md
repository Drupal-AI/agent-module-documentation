Entity Limit lets administrators cap how many entities (of any content entity type and selected bundles) a user may create, targeting limits per role or per individual user. It enforces the cap through Drupal's entity-create access system, blocking the create form once the count is reached.

---

Each limit is an `entity_limit` config entity (`/admin/structure/entity_limit`, permission `administer
entity limit`) holding an entity type, a set of bundles, a chosen limit plugin, a weight, and a `limits`
array of `{id, limit}` rows. Two limit plugins ship: **Role Limit** (`role_limit`, priority 1) mapping a
role → max count, and **User Limit** (`user_limit`, priority 0) mapping a specific user → max count; both
exclude the administrator role/users and treat `-1` as unlimited. Enforcement is via
`hook_entity_create_access()`: for the entity type/bundle being created, `EntityLimitInspector` collects
all applicable limit configs, orders them by config weight then plugin priority, resolves the applicable
count for the current account, and calls the plugin's `checkAccess()`, which counts the user's existing
owned entities of those bundles (an entity query filtered by the owner + bundle keys, `accessCheck(FALSE)`)
and forbids creation when the count meets or exceeds the limit — otherwise access is neutral. Limits are a
pluggable type (`@EntityLimit` annotation, `Plugin/EntityLimit` namespace, `entity_limit_info` alter) so
custom conditions can be added. The module provides a config schema and a list builder; there are no
Drush commands. A second permission, `manage entity limits`, exists but the admin routes are gated by
`administer entity limit`.

---

- Cap how many Article nodes a given role may create.
- Limit a specific user to N media items.
- Prevent authenticated users from creating more than a set number of nodes (spam/abuse control).
- Apply different creation limits to different roles for the same content type.
- Give a specific power user a higher (or unlimited, `-1`) limit than their role.
- Limit taxonomy term creation per role.
- Limit custom block (block_content) creation.
- Restrict comment or any owner-keyed content entity creation counts.
- Enforce a quota across several bundles of one entity type at once.
- Set an unlimited (`-1`) override for trusted roles while capping others.
- Prioritise which of several overlapping limits applies via config weight.
- Combine role and user limits and let plugin priority resolve conflicts.
- Manage editorial fair-use quotas without custom code.
- Block the entity add form automatically once a user hits their cap.
- Exempt administrators automatically (they always have full access).
- Throttle content creation to conserve server resources.
- Enforce a "one submission per user" style limit (limit = 1).
- Add a custom limit condition (e.g. per organic group, per time window) via a new `entity_limit` plugin.
- Audit which roles/users have which creation caps from the admin list.
- Apply limits to newly added bundles by editing an existing limit's bundle set.
- Roll out creation quotas as exportable configuration across environments.
- Stop a role from creating a second entity of a bundle after their first.
