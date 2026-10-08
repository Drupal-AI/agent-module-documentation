# Configuration

The settings form is at **Configuration → Development → OpenTelemetry**
(`/admin/config/development/opentelemetry`), behind the core **Administer site
configuration** permission.

## Settings, field by field

- **Endpoint** — the base URL of your OTLP collector. If left empty, the module
  falls back to `http://localhost:4318`.
- **Disable** — when ticked, no tracer is initialized. The module stays enabled
  but does nothing, which is handy for temporarily switching tracing off without
  uninstalling.
- **Ignore parent span** — when ticked, an incoming W3C `traceparent` header is
  ignored and a fresh root span is started, instead of continuing a trace begun
  upstream. Use this if you don't trust inbound headers and want to avoid
  orphaned or foreign spans.
- **Authorization** — a value sent as the `Authorization` header on export
  requests, for secured or SaaS endpoints. **Treat this as a secret** — prefer
  setting it via the environment (see below) rather than committing it to
  configuration.
- **OTLP protocol** — `http/protobuf` (the default), `http/json`, or `grpc`. If
  you choose `grpc` but the gRPC transport library isn't installed, the module
  falls back to `http/json` and shows an error.
- **Service name** — the `service.name` attached to your telemetry (required,
  defaults to `Drupal`). Set this per environment, for example `Drupal-prod`, so
  your dashboards can tell environments apart.
- **Debug mode** — prints the current trace ID and span ID to the Drupal
  messenger, useful while setting things up.
- **Logger deduplication** — on by default; suppresses repeated identical
  exporter error messages so a down collector doesn't flood your logs or slow the
  site.
- **Log requests** — when ticked, logs every request to the Drupal logger as a
  debug record with its trace ID.
- **Enabled span plugins** — checkboxes choosing which trace plugins are active
  (see below).

### Setting values from Drush

```bash
drush config:set opentelemetry.settings endpoint http://otel-collector:4318 -y
drush config:set opentelemetry.settings service_name Drupal-prod -y
```

## Environment‑variable overrides (important)

Rather than passing your settings straight to the SDK, the module writes them
into OpenTelemetry's standard `OTEL_*` environment variables — but only if the
variable isn't already set. That means anything defined in your real environment
or `settings.php` **wins**, and the settings form marks those fields as
"overridden".

| Setting | Environment variable |
|---------|---------------------|
| Service name | `OTEL_SERVICE_NAME` |
| Endpoint | `OTEL_EXPORTER_OTLP_ENDPOINT` |
| Protocol | `OTEL_EXPORTER_OTLP_PROTOCOL` |
| Authorization | `OTEL_EXPORTER_OTLP_HEADERS` (as `Authorization=<value>`) |

This is the recommended way to supply the **Authorization** credential: set
`OTEL_EXPORTER_OTLP_HEADERS` in the environment so the secret never lives in
exported config. Compression is always set to gzip. If everything is configured
through the environment, you can set `DRUPAL_OPENTELEMETRY_SETTINGS_SKIP_READING=1`
to skip reading the config entirely.

## Trace plugins — what gets traced

The **Enabled span plugins** checkboxes control which kinds of activity produce
spans:

| Plugin | On by default? | What it traces |
|--------|----------------|----------------|
| **Request** | Yes | The whole request, as the root span. |
| **Exception** | Yes | Unhandled exceptions. |
| **Database statement** | No | Every database statement. Available only on Drupal 10.1+; it's shown greyed out with a reason on older versions. |

Developers can add their own span types by writing an `opentelemetry_trace`
plugin — see the sibling [`agent/`](../agent/start.md) docs.

## How export works

Spans are batched and gzip‑compressed, then exported over your chosen OTLP
protocol to the configured endpoint. Telemetry leaving your site is intentional
and is governed entirely by the **endpoint** and **Authorization** settings — so
review those before enabling the module in production.
