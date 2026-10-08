# ai_observability (AI Observability) 1.4.x — agent index

Telemetry layer over **AI Core** (`ai`). Subscribes to AI Core's request/response
events and turns each AI provider call into (a) a structured **Drupal Logger** entry on
the `ai_observability` channel and (b) optional **OpenTelemetry** spans + token-usage
metrics. Defines no plugin types, entities, or Drush commands — it is pure configuration
plus event subscribers.

Mental model: an AI request fires `PreGenerateResponseEvent` / `PostGenerateResponseEvent`
/ `PostStreamingResponseEvent` (and `ProviderDisabledEvent`) → this module reads
`ai_observability.settings` → writes a log line with provider/model/operation/token-usage
context, and (if OTEL modules are installed and enabled) starts/ends a span named
"AI provider request" and increments token-usage counters.

- **Configure logging & OpenTelemetry export** (settings route, all config keys, OTEL setup) → [configure/ai_observability.md](configure/ai_observability.md)
- **Permissions** (`administer ai observability`) → [permissions/ai_observability.md](permissions/ai_observability.md)

Part of the `ai` project. Requires `ai:ai`. OpenTelemetry export additionally requires the
contrib `opentelemetry` module (spans) and `opentelemetry_metrics` module (metrics).
