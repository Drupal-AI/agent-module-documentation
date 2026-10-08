# Duplicate Role — agent index

Adds a "Duplicate" operation to the roles list that creates a new role and copies an existing
role's permissions into it. One form, one permission. No Drush, no plugins, no config schema.
Core `user` only.

- **The permission, the duplicate form, and the copy behavior** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Permission `administer duplicate role` — `restrict access: TRUE` (title "Duplicate user roles").
- Route `duplicaterole.overview` at `/admin/people/roles/duplicate/{role}` → `Form\DuplicateRoleForm`, requires that permission.
- UI entry points: `hook_entity_operation` adds a "Duplicate" op per role row (permission-checked); local action `duplicate_role.role_duplicate` on `entity.user_role.collection`.
- Submit: creates a `user_role` entity with the submitted `id`/`label`, then `user_role_grant_permissions($new, $base->getPermissions())` — copies permissions only (nothing else).
- The only trigger, `administer duplicate role`, is `restrict access: TRUE`, and the form copies an existing role's permissions rather than granting arbitrary ones.
