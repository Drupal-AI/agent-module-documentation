<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Workflows — agent index

Logs content-moderation workflow state changes on nodes (and groups). Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

> Logs only entities that have a moderation_state field (Content Moderation).

## Handler(s) registered

| type | operations |
|---|---|
| `workflows` | insert, update, delete |

## How it logs

`node_insert` / `_update` (and `group_insert` / `_update`) hooks log the moderation_state: on insert the initial state, on update the old->new transition (only when it changed).

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = entity id, `ref_char` = title/label; description names the workflow state transition.

## Enable & view

```bash
drush en event_log_track_workflows -y
```
View at `/admin/reports/events-track` (filter Type = workflows), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='workflows' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
