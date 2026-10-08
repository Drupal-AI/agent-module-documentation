# Permissions

Defined in `localgov_events_remove_expired.permissions.yml`.

| Permission | Machine name | restrict access | Grants |
|---|---|---|---|
| Administer expired events | `administer expired events` | TRUE | Access the settings form at `/admin/config/content/expired-events` (route `localgov_events_remove_expired.form`). |

- This is the only requirement on the settings route (`_permission: 'administer expired events'`).
- `restrict access: TRUE` flags it in the permissions UI as security-sensitive — grant only to trusted
  administrators, since the settings decide whether expired events are deleted permanently.
- The permission gates configuration only. The actual delete/unpublish/archive work runs unattended
  under cron and is not tied to any user's permissions.
