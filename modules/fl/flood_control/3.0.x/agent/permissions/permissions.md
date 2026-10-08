# Permissions

Defined in `flood_control.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer flood unblock` | Access the Flood control settings form (`/admin/config/people/flood-control`). Marked `restrict access` (trusted). |
| `flood unblock ips` | Access the Flood unblock screen (`/admin/people/flood-unblock`) to view and clear blocked IPs/users. |

Grant via drush:
```
drush role:perm:add support 'flood unblock ips'
```
Give helpdesk staff only `flood unblock ips` so they can clear lockouts without reaching the
threshold settings gated by `administer flood unblock`.
