# Permissions

Defined in `key.permissions.yml`. Both are **restricted / trusted** permissions.

| Permission | Gates |
|---|---|
| `administer keys` | Create, edit, delete keys and access the Keys listing (`/admin/config/system/keys`). |
| `administer key configuration overrides` | Manage Key Configuration Override entities (`/admin/config/development/configuration/key-overrides`). |

Grant via drush:
```
drush role:perm:add administrator 'administer keys'
```
