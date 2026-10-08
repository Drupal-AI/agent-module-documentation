<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Block content — agent index

Logs custom (content) block create, update and delete events. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `block_content` | insert, update, delete |

## How it logs

`block_content_insert` / `_update` / `_delete` entity hooks call `EventLogTrackManager::insert()`.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = block id, `ref_char` = block label; description includes bundle and published status.

## Enable & view

```bash
drush en event_log_track_block_content -y
```
View at `/admin/reports/events-track` (filter Type = block_content), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='block_content' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
