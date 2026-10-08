<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Configuration — agent index

Logs configuration changes with a field-level diff of what changed. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `config` | save, delete |

## How it logs

A `ConfigCrudEvent` subscriber on `ConfigEvents::SAVE` / `DELETE` logs `save`/`delete`; on save it builds a concise human diff of the changed keys (ignoring dependencies, uuid, _core, langcode, third_party_settings).

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_char` = the config object name; description is the diff (or 'Config added' / 'Config removed').

## Enable & view

```bash
drush en event_log_track_config -y
```
View at `/admin/reports/events-track` (filter Type = config), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='config' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
