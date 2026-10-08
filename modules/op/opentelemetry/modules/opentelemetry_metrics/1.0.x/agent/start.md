# OpenTelemetry Metrics — agent index

Submodule of `opentelemetry`. Developer API to record custom metrics and export them over OTLP.
Depends on `opentelemetry`. No settings form, permissions, or plugins.

- **The `opentelemetry.metrics` service: get a meter, create instruments, export lifecycle** →
  [api/metrics.md](api/metrics.md)

Key facts:
- Service `opentelemetry.metrics` (`OpentelemetryMetrics`), `event_subscriber` on `kernel.terminate`
  (-100); `getMeter($name): MeterInterface`.
- `ExportingReader` → OTLP `MetricExporter`; transport shared via
  `opentelemetry.transport.factory.provider` (`METRICS`), overrides `OTEL_EXPORTER_OTLP_METRICS_*`.
  See parent [configure/settings.md](../../../../1.0.x/agent/configure/settings.md).
