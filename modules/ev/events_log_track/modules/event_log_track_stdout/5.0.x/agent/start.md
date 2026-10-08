<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_stdout — agent index

Submodule of **events_log_track**. An **alternative logging backend** for containers: it mirrors
every ELT event to `php://stdout` / `php://stderr` (or Drupal's watchdog channel), using a
token-based format. It registers no tracker; it re-emits what the other submodules record.
Depends on `event_log_track` + contrib `token` + contrib **`log_stdout`** (`log_stdout:log_stdout`).

- Implements `hook_event_log_track_log_alternative` (`EventLogTrackStdoutHooks`) → forwards the
  prepared `$log` to `EventLogStdout::logEvent()` (service `logger.eventlog.stdout`, a PSR
  `LoggerInterface`).
- Renders the event through the `event-log` token format; newlines are escaped (`#012`/`#015`).
  For output_type `stdout` it writes to `php://stderr` when `log_stdout.settings.use_stderr` is
  on and severity ≤ WARNING, else `php://stdout`; for `watchdog` it logs on the
  `events_log_track` channel. Severity WARNING for `fail`, else NOTICE.
- **Config injected into the log_stdout settings form** (`log_stdout_config_form`) via
  `form_log_stdout_config_form_alter`. Config object `event_log_track_stdout.settings`
  (`format`, `output_type`).

- **The format string, output types, and config** → [configure/format.md](configure/format.md)

Intended for Docker/Kubernetes log capture; typically paired with the parent's `disable_db_logs`.
Shared logging pipeline and token type come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & tokens](../../../../5.0.x/agent/api/logging.md).
