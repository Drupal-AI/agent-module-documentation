Integrates Events Log Track with the log_stdout module: every ELT event is also written to `php://stdout` / `php://stderr` (or Drupal's watchdog channel), formatted with a configurable token template — ideal for Docker/Kubernetes log capture. It adds no new tracked events; it re-sends what the other submodules record.

---

`EventLogTrackStdoutHooks` implements `hook_event_log_track_log_alternative`, which the parent's `EventLogTrackManager::insert()` fires for every event, forwarding the prepared `$log` to `EventLogStdout::logEvent()` (the `logger.eventlog.stdout` PSR logger service). The event is rendered through the `event-log` token format stored in `event_log_track_stdout.settings`, its newlines escaped, given WARNING severity for `fail` operations and NOTICE otherwise, then either written straight to the PHP output stream (output type `stdout` — stderr when `log_stdout`'s `use_stderr` is on and severity ≤ WARNING, else stdout) or logged on the `events_log_track` channel (output type `watchdog`, the default). The format and output type are configured on the log_stdout settings form, where the submodule injects a format textarea, token tree, output-type select, and example. Pair it with the parent's `disable_db_logs` to log only to stdout. See configure/format.md.

---

- Stream audit events to container stdout/stderr for Docker/Kubernetes.
- Feed events into a cluster log aggregator (Loki, CloudWatch, Stackdriver).
- Keep audit logs out of the database on ephemeral containers.
- Format each event line with tokens (type, user, path, description).
- Route `fail`/warning events to stderr separately from stdout.
- Log only to stdout by disabling the ELT database table.
- Standardize audit output across containerized environments.
- Correlate Drupal audit events with container runtime logs.
- Avoid DB growth on high-volume or read-only-DB setups.
- Preview the rendered format before saving it.
- Include user roles per line via chained tokens.
- Integrate with 12-factor logging practices.
- Capture login/logout and 403 events in the container log stream.
- Ship audit data to a centralized observability stack.
- Keep an off-container copy of the audit trail via log shipping.
