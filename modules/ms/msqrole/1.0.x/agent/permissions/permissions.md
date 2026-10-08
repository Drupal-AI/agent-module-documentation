# Permissions

Defined in `msqrole.permissions.yml` plus a dynamic `permission_callbacks` entry
(`DynamicRolePermissions::callback`).

## Static permissions

| Permission | Gates |
|---|---|
| `masquerade role` | Use the masquerade form at `/admin/people/masquerade-role` (route `msqrole.form`) to view the site as other roles. |
| `create masquerade role link` | Create shareable links that activate a role set (via `RoleManager::generateUrl()`). |
| `administer masquerade role` | Change module settings at `/admin/config/people/masquerade-role` (restricted access). |

## Dynamic per-role permissions

For every **configurable** role the module generates a permission:

```
masquerade as <role_id>      // e.g. "masquerade as content_editor"
```

Title: *Masquerade as &lt;role label&gt;*. This is what actually authorizes impersonating a
particular role, so `masquerade role` (the form) plus `masquerade as <role_id>` (the target) are
both needed. "Configurable roles" are all roles **except** `anonymous`, `authenticated`, and
`administrator` (see `RoleManager::getConfigurableRoles()`), so no `masquerade as anonymous` /
`... authenticated` / `... administrator` permission is ever generated.

Grant these like any permission, e.g.:

```bash
drush role:perm:add content_editor 'masquerade role'
drush role:perm:add content_editor 'masquerade as content_editor'
```
