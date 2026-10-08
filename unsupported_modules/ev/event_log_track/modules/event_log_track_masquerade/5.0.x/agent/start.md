<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Masquerade — agent index

Logs when an admin starts and stops masquerading as another user. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

> Requires the contrib **Masquerade** module.

## Handler(s) registered

| type | operations |
|---|---|
| `masquerade` | masquerade, unmasquerade |

## How it logs

A kernel REQUEST subscriber watches the `entity.user.masquerade` and `masquerade.unmasquerade` routes and logs the start/stop, naming the admin and target user.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. No entity refs; the description carries the admin and target usernames and uids.

## Enable & view

```bash
drush en event_log_track_masquerade -y
```
View at `/admin/reports/events-track` (filter Type = masquerade), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='masquerade' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
