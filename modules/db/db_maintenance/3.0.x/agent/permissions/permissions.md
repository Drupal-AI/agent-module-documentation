# Permissions

The module defines exactly one permission (`db_maintenance.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer db maintenance` | Access to the settings form (`/admin/config/system/db_maintenance`), the overview menu block, and the manual "Optimize now" run (`/db_maintenance`). |

This permission is administrative (it lets a user run raw `OPTIMIZE TABLE`/`VACUUM` queries and
list all database tables), so grant it only to trusted administrator roles.

```bash
drush role:perm:add administrator 'administer db maintenance'
```
