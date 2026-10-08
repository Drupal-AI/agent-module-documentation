<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Comment — agent index

Logs comment create, update and delete events. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `comment` | insert, update, delete |

## How it logs

`comment_insert` / `_update` / `_delete` hooks call the manager.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = comment id, `ref_char` = comment subject; description includes the comment type.

## Enable & view

```bash
drush en event_log_track_comment -y
```
View at `/admin/reports/events-track` (filter Type = comment), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='comment' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
