<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – User — agent index

Logs user account create, update and delete events, including role changes. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `user` | insert, update, delete |

## How it logs

`user_insert` / `_update` / `_delete` hooks call the manager; the update description records original vs new roles and blocked/active status.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = uid, `ref_char` = username.

## Enable & view

```bash
drush en event_log_track_user -y
```
View at `/admin/reports/events-track` (filter Type = user), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='user' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
