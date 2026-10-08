# content_access — agent start

Fine-grained view/edit/delete node access by role, per content type and optionally per node
(and per user via the ACL module). Integrates with core node grants
(`hook_node_grants()` + `hook_node_access_records()`), realms `content_access_roles` and
`content_access_author`. Depends on core `node`. No global settings form (`configure` is null);
config lives on each content type's **Access control** tab. Manages **published** content only.

- Per-content-type + per-node access tabs, settings storage, node grants → [configure/settings.md](configure/settings.md)
- Permissions that gate the access tabs → [permissions/permissions.md](permissions/permissions.md)
- Procedural API (read/write settings, grants, ACL helpers) → [api/api.md](api/api.md)
- Hooks the module invites (`content_access.api.php`) → [hooks/hooks.md](hooks/hooks.md)
