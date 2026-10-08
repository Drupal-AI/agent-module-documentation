# Permissions

Defined in `redirect_after_login.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer redirect_after_login settings` | Access to the settings form (`redirect_after_login.admin_settings`, `/admin/config/people/redirect`) and its legacy redirect route. Marked `restrict access: true` (administrative/trusted). |

This is the only permission the module defines. There is no per-user or per-role *access*
gate on the redirect itself — the redirect fires for any authenticated user based on the
configured per-role destination map.

```
drush role:perm:add site_manager 'administer redirect_after_login settings'
```
