<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track – Cache Clear — agent index

Records who cleared the site cache. Submodule of **Events Log Track** (see the parent at `modules/event_log_track/5.0.x/` for the logging API, table schema, settings and report).

## Handler(s) registered

| type | operations |
|---|---|
| `cache_clear` | cache_clear |

## How it logs

`hook_cache_flush()` logs a single `cache_clear` event with the current user as the reference.

Each row goes into the `event_log_track` table via `event_log_track.manager`->`insert()`. `ref_numeric` = current uid, `ref_char` = current username; description is 'Cache cleared'.

## Enable & view

```bash
drush en event_log_track_clear_cache -y
```
View at `/admin/reports/events-track` (filter Type = cache_clear), or query directly:

```bash
drush sqlq "SELECT operation, ref_char, description, uid, created FROM event_log_track WHERE type='cache_clear' ORDER BY created DESC LIMIT 20"
```

Reminder: events triggered under Drush/CLI are only logged if the base setting `log_cli` is TRUE.
