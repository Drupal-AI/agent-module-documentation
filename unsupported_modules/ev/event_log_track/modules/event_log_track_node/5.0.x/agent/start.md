<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Node — agent index

Logs node create, update and delete events (and adds a Views relationship to nodes). Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `node` | insert, update, delete |

## How it logs

`node_insert` / `_update` / `_delete` hooks call the manager; a `views_data` hook adds the `elt_node_join` relationship to `node_field_data`.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = node id, `ref_char` = node title; description includes content type and published status.

## Enable & view

```bash
drush en event_log_track_node -y
```
View at `/admin/reports/events-track` (filter Type = node), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='node' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
