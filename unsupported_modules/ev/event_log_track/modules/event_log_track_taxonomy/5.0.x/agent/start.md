<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Taxonomy — agent index

Logs taxonomy vocabulary and term create, update and delete events. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `taxonomy` | vocabulary insert, vocabulary update, vocabulary delete, term insert, term update, term delete |

## How it logs

`taxonomy_vocabulary_*` and `taxonomy_term_*` hooks log vocabulary and term CUD via the manager.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. Terms: `ref_numeric` = tid, `ref_char` = vocabulary id. Vocabularies: `ref_char` = vid.

## Enable & view

```bash
drush en event_log_track_taxonomy -y
```
View at `/admin/reports/events-track` (filter Type = taxonomy), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='taxonomy' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
