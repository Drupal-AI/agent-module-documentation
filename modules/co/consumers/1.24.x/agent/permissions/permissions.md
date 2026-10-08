# Permissions

Defined in `consumers.permissions.yml`; enforced by `AccessControlHandler`.

| Permission | Gates |
|---|---|
| `administer consumer entities` | Access the admin configuration form for consumer entities. |
| `add consumer entities` | Create new consumers. |
| `view own consumer entities` | View consumers the user owns. |
| `update own consumer entities` | Edit consumers the user owns. |
| `delete own consumer entities` | Delete consumers the user owns. |

The `own` permissions let you delegate self-service client registration to non-admin roles
(e.g. app developers manage only their own consumers) while `administer consumer entities`
covers full management. Grant via drush, e.g.:
```
drush role:perm:add api_developer 'add consumer entities'
```
