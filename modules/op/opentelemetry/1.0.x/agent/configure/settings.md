# Configure OpenTelemetry

- Route `opentelemetry.settings` → `/admin/config/development/opentelemetry`.
- Access: **`administer site configuration`** (core permission, `restrict access: true`).
- Config object: `opentelemetry.settings` (schema `opentelemetry.schema.yml`).

## Settings keys (defaults from `config/install/opentelemetry.settings.yml`)

| Key | Form field | Default | Meaning |
|---|---|---|---|
| `endpoint` | url | `''` | OTLP collector base URL. Empty → fallback `http://localhost:4318`. |
| `disable` | checkbox | `false` | If true, no tracer is initialized (module stays enabled but inert). |
| `ignore_parent_span` | checkbox | `false` | Ignore an inbound W3C `traceparent` header (start a fresh root instead of continuing a foreign trace). |
| `authorization` | textarea | `''` | Value sent as the `Authorization` header (mapped to `OTEL_EXPORTER_OTLP_HEADERS=Authorization=…`). |
| `otel_exporter_otlp_protocol` | radios | `http/protobuf` | OTLP protocol: `http/protobuf` \| `http/json` \| `grpc`. |
| `service_name` | textfield (required) | `Drupal` | Telemetry resource `service.name`. |
| `debug_mode` | checkbox | `false` | Print the current trace id / span id to the Drupal messenger. |
| `logger_deduplication` | checkbox | `true` | Suppress consecutive identical exporter log messages (protects the site if the collector is down). |
| `span_plugins_enabled` | checkboxes | `{request, exception}` | Which `opentelemetry_trace` plugins are active (see [plugins/trace.md](../plugins/trace.md)). |
| `log_requests` | checkbox | `false` | Log every request to the Drupal logger as a DEBUG record with its trace id. |

## Config → environment mapping (important)

`OpentelemetryTransportFactoryProvider::applyConfiguration()` does **not** feed the SDK directly; it
writes the config into the SDK's standard environment variables with `putenv()` **only if the variable
is not already set** (`fillEnv`), so anything defined in the real environment or `settings.php` wins:

| Setting | Env var |
|---|---|
| `service_name` | `OTEL_SERVICE_NAME` |
| `endpoint` | `OTEL_EXPORTER_OTLP_ENDPOINT` |
| `otel_exporter_otlp_protocol` | `OTEL_EXPORTER_OTLP_PROTOCOL` |
| `authorization` | `OTEL_EXPORTER_OTLP_HEADERS` (`Authorization=<value>`) |
| (fixed) | `OTEL_EXPORTER_OTLP_COMPRESSION=gzip` |

The form flags any of these as "overridden" when the corresponding `OTEL_*` (including per-signal
`_TRACES_/_METRICS_/_LOGS_`) env var is already present. Setting env
`DRUPAL_OPENTELEMETRY_SETTINGS_SKIP_READING=1` skips reading config entirely (use when everything is
configured through the environment).

## gRPC fallback

If protocol is `grpc` but the `open-telemetry/transport-grpc` library / `GrpcTransport` class is
missing, it forces `http/json` and shows an error message. Install `open-telemetry/transport-grpc` to
use gRPC.

## Drush / config quick set

```bash
ddev drush config:set opentelemetry.settings endpoint http://otel-collector:4318 -y
ddev drush config:set opentelemetry.settings service_name Drupal-prod -y
```

## Export behavior

Spans go through a `BatchSpanProcessor` → `SpanExporter` (OTLP) over the chosen protocol with gzip.
Default endpoint when unset is `http://localhost:4318`. Telemetry leaving the site is intentional and
governed entirely by `endpoint` / `authorization`.
