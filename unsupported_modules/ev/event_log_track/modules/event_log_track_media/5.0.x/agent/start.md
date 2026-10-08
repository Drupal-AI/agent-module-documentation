<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Media — agent index

Logs media entity create, update and delete events (and adds a Views relationship to media). Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `media` | insert, update, delete |

## How it logs

`media_insert` / `_update` / `_delete` hooks call the manager; a `views_data` hook adds the `elt_media_join` relationship to `media_field_data`.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = media id, `ref_char` = media label; description includes bundle and revision log.

## Enable & view

```bash
drush en event_log_track_media -y
```
View at `/admin/reports/events-track` (filter Type = media), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='media' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
