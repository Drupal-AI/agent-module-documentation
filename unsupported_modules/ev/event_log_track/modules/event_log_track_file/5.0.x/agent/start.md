<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – File — agent index

Logs managed file create, update and delete events. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `file` | insert, update, delete |

## How it logs

`file_insert` / `_update` / `_delete` hooks call the manager.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = file id, `ref_char` = filename; description = the file URI.

## Enable & view

```bash
drush en event_log_track_file -y
```
View at `/admin/reports/events-track` (filter Type = file), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='file' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
