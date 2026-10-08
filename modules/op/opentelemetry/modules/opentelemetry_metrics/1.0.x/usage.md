Submodule of OpenTelemetry that gives Drupal code an API to record custom metrics (counters, histograms, gauges) and push them over OTLP to an OpenTelemetry metrics receiver.

---

It provides the `opentelemetry.metrics` service (`Drupal\opentelemetry_metrics\OpentelemetryMetrics`), an event subscriber on `kernel.terminate` that exposes `getMeter($name)` returning an OpenTelemetry `MeterInterface`; from a meter you create instruments (counter, up-down counter, histogram, observable gauge) and record values. Metrics are read by an `ExportingReader` and flushed on request terminate through an OTLP `MetricExporter`, using the same shared transport/endpoint plumbing as the parent module (`opentelemetry.transport.factory.provider`, data type `METRICS`, honoring `OTEL_EXPORTER_OTLP_METRICS_*` overrides). The resource info comes from `ResourceInfoFactory::defaultResource()`. Depends only on the parent `opentelemetry` module; no settings form, permissions, or plugins — it's a developer API.

---

- Record a custom counter (e.g. number of orders placed) and export it via OTLP.
- Track a histogram of operation durations (e.g. search query latency).
- Emit an observable gauge for a live value (queue depth, cache size).
- Push business/application metrics to Prometheus/Grafana via an OTel collector.
- Instrument a custom module's hot path with counters from code.
- Reuse the parent module's OTLP endpoint/auth for metrics (no separate config).
- Override the metrics endpoint/protocol independently via `OTEL_EXPORTER_OTLP_METRICS_*`.
- Flush metrics automatically at request end (terminate event).
- Correlate metrics with traces/logs by shared service/resource attributes.
- Build SLO dashboards from Drupal-emitted metrics.
- Count error occurrences or feature usage across requests.
- Add up-down counters for gauge-like values that rise and fall.
- Name meters per subsystem for organized metric namespaces.
- Provide APM-style metrics without writing an exporter by hand.
- Route metrics through an OpenTelemetry Collector to Prometheus/other backends.
- Instrument cron/queue jobs with counters for throughput monitoring.
