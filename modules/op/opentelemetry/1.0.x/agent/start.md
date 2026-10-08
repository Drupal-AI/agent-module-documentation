# OpenTelemetry — agent index

Instruments Drupal with OpenTelemetry (opentelemetry-php SDK): a root span per request, span export
over OTLP to a collector, plus pluggable trace types. Configure at `opentelemetry.settings`
(`/admin/config/development/opentelemetry`, permission `administer site configuration`). Bundles a
plugin type and three submodules. External libraries required (see data.json). No Drush command.

- **Every settings key, defaults, env/`OTEL_*` overrides, endpoint & protocol, auth header** →
  [configure/settings.md](configure/settings.md)
- **The `opentelemetry_trace` plugin type — bundled plugins and how to add one** →
  [plugins/trace.md](plugins/trace.md)
- **The `opentelemetry` service: getTracer(), root span, creating custom spans, event subscribers** →
  [api/service.md](api/service.md)

Submodules (own docs):
- `opentelemetry_logs` →
  [../../modules/opentelemetry_logs/1.0.x/agent/start.md](../../modules/opentelemetry_logs/1.0.x/agent/start.md)
- `opentelemetry_syslog` →
  [../../modules/opentelemetry_syslog/1.0.x/agent/start.md](../../modules/opentelemetry_syslog/1.0.x/agent/start.md)
- `opentelemetry_metrics` →
  [../../modules/opentelemetry_metrics/1.0.x/agent/start.md](../../modules/opentelemetry_metrics/1.0.x/agent/start.md)

Key facts:
- Service `opentelemetry` (`OpentelemetryService`) subscribes to `kernel.terminate` (-100): opens the
  root span in its constructor, ends + `forceFlush()` on terminate.
- Bundled trace plugins: `request`, `exception` (both default-on), `database_statement` (core ≥ 10.1).
- Config `opentelemetry.settings` is mapped to standard `OTEL_*` env vars by
  `OpentelemetryTransportFactoryProvider`; real env/`settings.php` values take precedence.
- Default endpoint fallback `http://localhost:4318`, protocol `http/protobuf`, gzip compression,
  `BatchSpanProcessor`.
