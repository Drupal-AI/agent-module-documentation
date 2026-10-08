<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_syslog — agent index

Submodule of **events_log_track**. An **alternative logging backend**: it mirrors every ELT
event to syslog (raw) or to Drupal's logger/watchdog channel, using a token-based format
string. It does **not** register a tracker; it re-emits whatever the other submodules record.
Depends on `event_log_track` + core `syslog` + contrib `token`.

- Implements `hook_event_log_track_log_alternative` (`EventLogTrackSyslogHooks`) → forwards the
  prepared `$log` to `EventLog::logEvent()` (service `logger.eventlog`, a PSR `LoggerInterface`).
- The event is rendered through the `event-log` token format, then either sent to raw
  `syslog()` (output_type `syslog`) or logged on the `events_log_track` channel
  (output_type `watchdog`, the default). Severity is WARNING for `fail` operations, else NOTICE.
- **Config injected into the core Syslog settings form** (`system_logging_settings`) via
  `form_system_logging_settings_alter`: a format textarea, a token tree, an output-type select,
  and a live example. Config object `event_log_track_syslog.settings` (`format`, `output_type`).

- **The format string, output types, and config** → [configure/format.md](configure/format.md)

Typically paired with the parent's `disable_db_logs` to log only to syslog. Shared logging
pipeline and token type come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & tokens](../../../../5.0.x/agent/api/logging.md).
