# group — agent start

Groups users, content and other entities into access-controlled "groups". A `group`
(content entity) of a `group_type` (config) relates entities through `group_relationship`
(content entity) records governed by `GroupRelationType` plugins; per-group access comes from
`group_role` config entities via the `flexible_permissions` module. Depends on core `options`,
contrib `entity`, and `flexible_permissions`. Config UI: **Admin → Groups → Settings**
(`/admin/group/settings`); settings route `group.settings`.

**v3 rename:** the old `GroupContent` entity → `group_relationship`; `GroupContentType` →
`group_relationship_type`; the `GroupContentEnabler` plugin type → `GroupRelationType`.

- Group types, roles, scopes, enabling content plugins, settings → [configure/group.md](configure/group.md)
- The `GroupRelationType` plugin type — make an entity type groupable → [plugins/group.md](plugins/group.md)
- Members, relationships, permission checks in code (entity + services) → [api/group.md](api/group.md)
- Permissions (sitewide + per-group) → [permissions/group.md](permissions/group.md)
- Decorating relation handlers to alter behaviour → [extend/group.md](extend/group.md)
- Submodules: `modules/gnode` (relate nodes), `modules/group_support_revisions` (per-group revision access)
