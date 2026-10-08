Instruments Drupal with OpenTelemetry: wraps each request in a root trace span and exports spans (and, via submodules, logs and metrics) over OTLP to a configured OpenTelemetry collector/APM backend using the official opentelemetry-php SDK.

---

On every request the `opentelemetry` service (an event subscriber on `kernel.terminate`) opens a **root server span** named `"$METHOD $uri"` with HTTP/URL/network semantic-convention attributes, honoring an incoming W3C `traceparent` header unless "ignore parent" is set, and ends/flushes it at request end. What gets traced is decided by **OpenTelemetryTrace plugins** — bundled ones are `request`, `exception`, and `database_statement` (the last requires core ≥ 10.1) — toggled on the settings form and enabled-by-default via each plugin's `enabledByDefault()`. Export configuration lives in `opentelemetry.settings` (endpoint, OTLP protocol `http/protobuf` | `http/json` | `grpc`, an `Authorization` header, service name, parent handling, debug mode, logger deduplication, and the per-plugin enable list). Rather than passing these directly to the SDK, `OpentelemetryTransportFactoryProvider` translates the config into the SDK's standard `OTEL_*` environment variables (via `putenv`), so any value already set in the real environment/`settings.php` wins and the form shows an "overridden" note; gRPC gracefully falls back to `http/json` if the `open-telemetry/transport-grpc` library is missing. The exporter uses a `BatchSpanProcessor` with gzip compression and a default endpoint of `http://localhost:4318`. Three submodules extend the same transport/config plumbing: `opentelemetry_logs` (a PSR/Drupal logger that pushes log records over OTLP), `opentelemetry_syslog` (swaps core's syslog logger to inject the trace id into syslog lines), and `opentelemetry_metrics` (an API to push custom metrics). The exported telemetry leaving the site is by design; the endpoint and any auth header are operator configuration.

---

- Trace every Drupal/Symfony request end-to-end as a root span in an APM backend (Jaeger, Tempo, Grafana, Honeycomb, Elastic APM, etc.).
- Export spans over OTLP `http/protobuf`, `http/json`, or `grpc` to an OpenTelemetry collector.
- Continue a distributed trace by honoring an incoming W3C `traceparent` header.
- Ignore untrusted inbound `traceparent` headers to avoid orphaned/foreign spans.
- Capture unhandled exceptions as spans via the `exception` trace plugin.
- Trace individual database statements (core ≥ 10.1) via the `database_statement` plugin.
- Add a custom span type by writing an `OpenTelemetryTrace` plugin.
- Set the OTLP collector endpoint and service name for the site's telemetry resource.
- Send an `Authorization` header to a secured/SaaS OTLP endpoint.
- Override any export setting from the environment or `settings.php` using standard `OTEL_*` variables.
- Batch and gzip-compress span export to reduce overhead.
- Turn on debug mode to surface the current trace id and span id in the Drupal messenger.
- Deduplicate repeated exporter error log messages to avoid slowing the site when the collector is down.
- Log every request to the Drupal logger as a debug record with its trace id.
- Push Drupal log entries to an OTLP logs receiver via the `opentelemetry_logs` submodule.
- Inject the OpenTelemetry trace id into syslog lines via the `opentelemetry_syslog` submodule.
- Emit custom application metrics (counters/histograms) via the `opentelemetry_metrics` submodule API.
- Correlate logs, traces, and metrics for a single request across your observability stack.
- Disable tracing entirely with the `disable` flag while keeping the module installed.
- Name the service per environment (e.g. "Drupal-prod") for multi-environment dashboards.
- Fall back automatically from gRPC to `http/json` when the gRPC transport library is absent.
- Measure request latency and error rates for performance monitoring and SLOs.
