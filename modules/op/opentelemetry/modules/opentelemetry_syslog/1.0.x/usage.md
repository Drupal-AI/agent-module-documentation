Submodule of OpenTelemetry that overrides Drupal core's syslog logger so the current OpenTelemetry trace id can be embedded in each syslog line via a `!trace_id` token, letting you correlate raw syslog output with distributed traces.

---

A service provider (`OpentelemetrySyslogServiceProvider::alter()`) swaps the class of the core `logger.syslog` service to `Drupal\opentelemetry_syslog\Logger\OpenTelemetrySysLog`, a subclass of core's `SysLog`. That subclass overrides `syslogWrapper()` to replace a `!trace_id` placeholder in the formatted log line with `\Drupal::service('opentelemetry')->getTraceId()` just before the line is written. On install, `hook_install()` seeds core `syslog.settings:format` with a trailing `|!trace_id`, and `hook_form_system_logging_settings_alter()` adds help text documenting the placeholder on the core Logging settings form (`/admin/config/development/logging`), where core Syslog's format field also lives. Depends on core `syslog` and the parent `opentelemetry` module. It defines no settings form (its info.yml `configure` route is a dead reference), no permissions, config schema, plugins, drush commands, or services of its own beyond the logger override.

---

- Include the current OpenTelemetry trace id in every syslog log line.
- Correlate syslog entries with traces in Jaeger/Tempo/Grafana by trace id.
- Add the `!trace_id` token to the core Syslog format string.
- Debug production issues by pivoting from a syslog line to its full trace.
- Keep using core syslog logging while gaining trace context.
- Ship trace-tagged logs to an external syslog/log aggregation pipeline.
- Bridge classic syslog-based ops tooling with OpenTelemetry observability.
- Avoid writing custom logger code just to get trace ids into logs.
- Provide request-level correlation for log-based alerting.
- Enrich SIEM/log ingestion with trace identifiers.
- Trace-tag logs written to `/dev/log` or a remote syslog host.
- Group all log lines from one request by their shared trace id.
- Speed up incident triage by jumping from a syslog alert to the trace waterfall.
- Keep trace correlation even for code paths that log before/after a traced span.
- Standardize log-to-trace correlation across multiple Drupal sites shipping to one collector.
- Reorder or customize the syslog format while retaining the `!trace_id` token.
- Feed trace ids into Grafana Loki/Elastic log indexes for trace-log linking.
- Diagnose slow requests by finding their trace directly from a logged warning.
