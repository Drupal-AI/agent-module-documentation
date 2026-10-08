# configure — logging & OpenTelemetry export

Config UI: **/admin/config/ai/observability** (route `ai_observability.settings`,
menu link under *AI → Safety*). Requires the `administer ai observability` permission.
All settings live in the `ai_observability.settings` config object
(`config/install/ai_observability.settings.yml`).

## Two independent subsystems

1. **Drupal Logger** — always active (its event subscriber is registered unconditionally).
   Writes to the dedicated `ai_observability` logger channel via `logger->info()`. Where
   entries end up depends on Drupal's logging config (database, Syslog, file, cloud
   collector). For local viewing the README suggests the Extended Logger + Extended Logger
   DB modules.
2. **OpenTelemetry** — only wired up when the corresponding contrib modules are installed:
   spans need the `opentelemetry` module, metrics need the `opentelemetry_metrics` module
   (`AiObservabilityServiceProvider` registers the subscribers conditionally; the form
   disables the OTEL checkboxes when the module is absent).

## `ai_observability.settings` keys

| Key | Default | Meaning |
|---|---|---|
| `logging_enabled` | `true` | master switch for the Drupal Logger path |
| `log_event_types` | `[PreGenerateResponseEvent, PostGenerateResponseEvent, PostStreamingResponseEvent]` | fully-qualified event classes to log; also available: `ProviderDisabledEvent` |
| `log_input` | `false` | also log the input prompt text (as a `input` context field) plus guardrail results |
| `log_output` | `false` | also log the provider's output/response |
| `log_tags` | `[]` | if non-empty, only log requests whose tags intersect this list; empty = log all |
| `fallback_log_message_mode` | `true` | `true` = Drupal-style `@placeholder` message (core-logger compatible); `false` = PSR-3 `{placeholder}` style (smaller/faster with a structured logger) |
| `otel_enabled` | `false` | master switch for OpenTelemetry export (needs `opentelemetry`) |
| `otel_spans` | `true` | export each AI request as a span (only takes effect when `otel_enabled`) |
| `otel_spans_store_input` | `false` | add input text as span attribute `input` |
| `otel_spans_store_output` | `false` | add output text as span attribute `output` |
| `otel_metrics` | `true` | export token usage as OTEL metrics (needs `opentelemetry_metrics`) |

## What gets emitted

**Logger context metadata** on each entry: `event_name`, `tags`, `provider`,
`operation_type`, `model`, `provider_request_id`, `provider_request_parent_id`,
`configuration`, `token_usage` (on response events), plus `input`/`guardrails` and `output`
when the respective toggles are on. Message reads e.g. `Response from provider <id>: model:
…, operation type: …, token usage: …`.

**OTEL span**: name `AI provider request`; attributes `provider`, `operation_type`,
`model`, `provider_request_id`, `provider_request_parent_id`, `configuration` (JSON),
`tags`, `token_usage`, and optionally `input` / `output`.

**OTEL metrics**: meter `ai_observability.token_usage`; one counter per token-usage key
named `ai_token_usage_<key>` (e.g. `ai_token_usage_total`) with attributes `uid`,
`provider`, `operation_type`, `model`.

## Setting values with drush

```bash
# Inspect current settings.
drush config:get ai_observability.settings

# Turn logging on/off.
drush config:set ai_observability.settings logging_enabled true -y

# Opt in to logging prompt input and provider output (privacy-sensitive).
drush config:set ai_observability.settings log_input true -y
drush config:set ai_observability.settings log_output true -y

# Enable OpenTelemetry export (requires the opentelemetry / opentelemetry_metrics modules).
drush config:set ai_observability.settings otel_enabled true -y
```

Note: `log_input`/`log_output` (and the `otel_spans_store_*` equivalents) persist raw
prompts and responses — leave them off unless you need the content and understand the
privacy/storage impact.
