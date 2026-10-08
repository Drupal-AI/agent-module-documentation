# view_unpublished — agent start

Grants roles read-only access to unpublished nodes via core's node-grants system.
Depends on core `node`. No config UI — everything is done through permissions at
**People → Permissions**. Purely additive: never grants edit/delete. Grants are
recorded per translation (multilingual-aware). On install/uninstall the module
auto-flags a node-access rebuild when unpublished nodes exist.

- Permissions (global + per-content-type) → [permissions/permissions.md](permissions/permissions.md)
- Views integration (which filter to use) → [configure/views.md](configure/views.md)
