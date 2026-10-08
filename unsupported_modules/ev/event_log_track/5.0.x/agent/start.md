<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track — agent index

Records user CUD (and other) events into the `event_log_track` DB table, shown as an admin report.
The base module is the storage + report + API; **enable a submodule** to actually log an entity
type (node, user, taxonomy, config, media, file, …). See each submodule's own docs under
`modules/event_log_track/modules/<sub>/5.0.x/`.

- **Settings form, config keys, cron log deletion, report location & permission** →
  [configure/settings.md](configure/settings.md)
- **Logging API: `EventLogTrackManager::insert()`, the log/table schema, `EventLogTrackApi`** →
  [api/logging.md](api/logging.md)
- **Extend it: `hook_event_log_track_handlers`, `_alter`, `_log_alternative` (add a custom event type)** →
  [hooks/extend.md](hooks/extend.md)

Key facts: report View at `/admin/reports/events-track` (permission `access event log track`);
settings at `/admin/config/system/events-log-track` (route `event_log_track.settings_form`).
Service `event_log_track.manager`. A logged row = `type`, `operation`, `description`,
`ref_numeric`, `ref_char`, `uid`, `ip`, `path`, `created`. **CLI/Drush events are NOT logged
unless `log_cli` is TRUE.** Config `event_log_track.settings`:
`enable_log_deletion`, `timespan_limit`, `batch_size`, `disable_db_logs`, `log_cli`, `skip_patterns`.
