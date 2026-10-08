# ClamAV Permissions

Defined in `clamav.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer clamav` | Access to the ClamAV configuration form at `/admin/config/media/clamav` (route `clamav.admin_display`). |

This is the only permission the module defines. It is the sole access requirement on the
config route. Grant it only to trusted administrators — it controls scan mode, daemon
host/socket, the `clamscan` executable path/parameters, and the fail-open/fail-closed
outage behavior. There is no separate permission for file scanning itself: scanning happens
automatically during file upload/validation for all users, governed by the `enabled` setting.

```bash
drush role:perm:add administrator 'administer clamav'
```
