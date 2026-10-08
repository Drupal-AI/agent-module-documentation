Submodule of OpenTelemetry that registers a Drupal logger which forwards log records over OTLP to an OpenTelemetry logs receiver, so Drupal's watchdog/PSR log messages land in your observability backend alongside traces and metrics.

---

It defines the `opentelemetry.logs` service (`Drupal\opentelemetry_logs\Logger\OpentelemetryLogs`), tagged as a `logger` and an `event_subscriber`, that implements the PSR `LoggerInterface` via `RfcLoggerTrait`. Each `log()` call maps Drupal's RFC log level to an OpenTelemetry `Severity`, parses message placeholders, attaches semantic-convention attributes (code, HTTP/URL, client, user, error, backtrace) and emits an OTLP `LogRecord` through a `LoggerProvider` backed by a `BatchLogRecordProcessor` and an OTLP `LogsExporter`. Transport/endpoint/protocol are shared with the parent module via `opentelemetry.transport.factory.provider` (data type `LOGS`), so it uses the same `endpoint`/`authorization`/protocol config (and per-signal `OTEL_EXPORTER_OTLP_LOGS_*` overrides). Depends only on the parent `opentelemetry` module. No settings form, permissions, or plugins of its own — enabling it starts shipping logs.

---

- Export Drupal log messages to an OpenTelemetry (OTLP) logs endpoint.
- Centralize watchdog logs in an observability backend (Grafana Loki, Elastic, Honeycomb, etc.).
- Correlate logs with traces and metrics by shared resource/service attributes.
- Batch and export log records efficiently via `BatchLogRecordProcessor`.
- Map Drupal RFC severities to OpenTelemetry log severities automatically.
- Enrich exported logs with HTTP/URL/user/error semantic-convention attributes.
- Reuse the parent module's OTLP endpoint and auth for logs (no separate config).
- Override the logs endpoint/protocol independently via `OTEL_EXPORTER_OTLP_LOGS_*` env vars.
- Add another logger backend without removing core dblog/syslog.
- Ship structured logs to a SaaS APM alongside request traces.
- Capture error/exception logs with backtrace attributes for debugging.
- Feed a unified logs+traces+metrics pipeline from one Drupal module family.
- Attach the current user, HTTP method, and URL to each exported log record.
- Batch-export logs on request terminate to minimize per-request overhead.
- Route Drupal logs to an OpenTelemetry Collector for fan-out to multiple sinks.
- Keep an on-site dblog while also streaming logs off-box for retention.
