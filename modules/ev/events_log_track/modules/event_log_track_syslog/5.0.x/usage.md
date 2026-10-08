Integrates Events Log Track with syslog: every ELT event is also emitted to syslog (raw) or to Drupal's logger/watchdog channel, formatted with a configurable token template. It adds no new tracked events — it re-sends what the other submodules already record.

---

`EventLogTrackSyslogHooks` implements `hook_event_log_track_log_alternative`, which the parent's `EventLogTrackManager::insert()` fires for every event before the DB write, forwarding the prepared `$log` to `EventLog::logEvent()` (the `logger.eventlog` PSR logger service). The event is rendered through the `event-log` token format string stored in `event_log_track_syslog.settings` (a required format missing the key placeholders falls back to a built-in default), given WARNING severity for `fail` operations and NOTICE otherwise, then either written straight to `syslog()` (output type `syslog`) or logged on the `events_log_track` channel (output type `watchdog`, the default). The format and output type are configured on the core Syslog settings page (`/admin/config/development/logging`), where the submodule injects a format textarea, a token tree, an output-type select, and a live example. Pair it with the parent's `disable_db_logs` to log only to syslog. See configure/format.md.

---

- Ship audit events to a central syslog collector or SIEM.
- Forward login/logout and 403 events to security monitoring.
- Format each event line with tokens (type, user, path, description).
- Choose raw `syslog()` output or Drupal's watchdog channel.
- Log only to syslog by disabling the ELT database table.
- Reduce DB growth on high-volume sites by externalizing logs.
- Give `fail` operations WARNING severity for alerting.
- Standardize audit lines across many Drupal sites.
- Integrate with log rotation and retention at the OS level.
- Correlate Drupal audit events with server-level logs.
- Use the core syslog identity/facility for routing.
- Preview the rendered format before saving it.
- Include user roles in each log line via chained tokens.
- Feed events into Graylog/ELK/Splunk pipelines.
- Keep a tamper-resistant off-box copy of the audit trail.
