<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track (events_log_track) — agent index

Audit-trail engine that records user CUD (create/update/delete) and other events into a
custom `event_log_track` database table, viewable at `admin/reports/events-track` (a Views
page). The base module ships the storage table, the logging service, the pluggable
**handler** system (a hook, not an annotated plugin type), Views integration, an `event-log`
token type, and a cron-based log-pruning job. The **per-subsystem tracking lives in ~19
opt-in submodules** (node, user, config, media, webform, …); enable only the areas to audit.

Machine name **`event_log_track`** (project is plural `events_log_track`). Version 5.0.0,
core `^11.3 || ^12.0`. Config route `event_log_track.settings_form`. Package Logging.

- **How events are recorded + how to register a custom tracker (`hook_event_log_track_handlers`), the alter hooks, and the alt-backend hook** → [hooks/event-handlers.md](hooks/event-handlers.md)
- **The logging service (`EventLogTrackManager::insert()`), the log-array shape, the `event_log_track` table, tokens, and pruning API** → [api/logging.md](api/logging.md)
- **Settings form / config object (retention, disable DB logging, log CLI, skip patterns)** → [configure/settings.md](configure/settings.md)
- **Permission that guards the report** → [permissions/access.md](permissions/access.md)
- **Views integration (base table, options callbacks, bundled view)** → [views/views.md](views/views.md)

Key facts:
- Table `event_log_track`: `lid, type, operation, path, ref_numeric, ref_char, description, uid, ip, created` (see api/logging.md for the schema).
- Services: `event_log_track.manager` (`Drupal\event_log_track\EventLogTrackManager`) — writes logs; `event_log_track.api` (`Drupal\event_log_track\EventLogTrackApi`) — retention batch + Views options callbacks.
- Config object `event_log_track.settings`: `enable_log_deletion`, `timespan_limit`, `batch_size`, `disable_db_logs`, `log_cli`, `skip_patterns`.
- Permission `access event log track`. Settings route requires `administer site configuration`.
- Integrator hooks: `hook_event_log_track_handlers()`, `hook_event_log_track_handlers_alter()`, `hook_event_log_track_alter()`, `hook_event_log_track_log_alternative()`.
- Token type `event-log` (`[event-log:type]`, `[event-log:operation]`, `[event-log:description]`, `[event-log:user:*]`, `[event-log:session_duration]`, …) used by the syslog/stdout submodules' format strings.
