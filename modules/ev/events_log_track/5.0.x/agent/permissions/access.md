# Permissions

Defined in `event_log_track.permissions.yml`:

| Permission | Guards |
| --- | --- |
| `access event log track` | Reading the logged events — the `event_log_track` Views page at `admin/reports/events-track` (the bundled view's access is `perm: 'access event log track'`). |

Notes:
- This permission only controls **viewing** the audit log. Restrict it to trusted roles: the
  log can contain usernames, IPs, entity labels, config diffs, and (via the config submodule)
  changed config values.
- The **settings** form is gated separately by the core `administer site configuration`
  permission (see configure/settings.md), not by this permission.
- Submodules do not add permissions of their own; all reading is governed by this one string.
