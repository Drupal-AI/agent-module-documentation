<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Group — agent index

Logs Group entity create, update and delete events. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

> Requires the contrib **Group** module; enable it (and this submodule) to log group events.

## Handler(s) registered

| type | operations |
|---|---|
| `group` | insert, update, delete |

## How it logs

`group_insert` / `_update` / `_delete` hooks call the manager; the description includes any revision log message.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = group id, `ref_char` = group label.

## Enable & view

```bash
drush en event_log_track_group -y
```
View at `/admin/reports/events-track` (filter Type = group), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='group' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
