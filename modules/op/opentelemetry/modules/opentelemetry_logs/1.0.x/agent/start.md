# OpenTelemetry Logs — agent index

Submodule of `opentelemetry`. Registers a Drupal logger that pushes log records over OTLP to an
OpenTelemetry logs receiver. Depends on `opentelemetry`. No settings form, permissions, or plugins —
enabling it starts exporting logs.

Key facts:
- Service `opentelemetry.logs` (`OpentelemetryLogs`), tagged `logger` + `event_subscriber`, implements
  PSR `LoggerInterface` via `RfcLoggerTrait`; logger name `org.drupal.opentelemetry_logs`.
- Each log → OTLP `LogRecord` (severity mapped from Drupal RFC level, semantic-convention attributes)
  via `LoggerProvider` → `BatchLogRecordProcessor` → OTLP `LogsExporter`.
- Endpoint/protocol/auth shared with the parent through `opentelemetry.transport.factory.provider`
  (`LOGS`); per-signal override env vars `OTEL_EXPORTER_OTLP_LOGS_*`. See parent
  [configure/settings.md](../../../../1.0.x/agent/configure/settings.md).
