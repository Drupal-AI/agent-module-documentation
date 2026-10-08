<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Webform Submission — agent index

Logs webform submission create, update, delete, view, download and clear events. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

> Requires the contrib **Webform** module.

## Handler(s) registered

| type | operations |
|---|---|
| `webform_submission` | insert, update, delete, view, download, clear |

## How it logs

`webform_submission_*` and `entity_view` hooks log submission CUD and `view`; a controller subscriber logs `download` and `clear` on the results export/clear routes.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = submission id, `ref_char` = webform id.

## Enable & view

```bash
drush en event_log_track_webform -y
```
View at `/admin/reports/events-track` (filter Type = webform_submission), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='webform_submission' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
