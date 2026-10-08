<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Group membership — agent index

Logs group membership (add/change-role/remove) events. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

> Requires the contrib **Group** module (supports Group 2.x `group_content` and 3.x `group_relationship` hooks).

## Handler(s) registered

| type | operations |
|---|---|
| `group_membership` | insert, update, delete |

## How it logs

`group_content_*` (Group 2.x) and `group_relationship_*` (Group 3.x) hooks log membership add/role-change/remove, recording user, group and roles.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = membership id, `ref_char` = user/label; description names the user, group and roles.

## Enable & view

```bash
drush en event_log_track_group_membership -y
```
View at `/admin/reports/events-track` (filter Type = group_membership), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='group_membership' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
