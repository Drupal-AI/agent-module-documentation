AI Observability is a submodule of AI Core that records every call made through the `ai` module's provider layer, writing structured entries to the Drupal Logger and, optionally, exporting traces and metrics to OpenTelemetry.

---

The module subscribes to AI Core's request/response events (`PreGenerateResponseEvent`, `PostGenerateResponseEvent`, `PostStreamingResponseEvent`, and `ProviderDisabledEvent`) and turns each into an observability signal. Its Drupal Logger path logs to the dedicated `ai_observability` channel with rich context — provider, model, operation type, request/parent request ids, configuration, token usage, and optionally the input prompt text, guardrail results, and output. Because it only emits standard log entries, those can land wherever your logger routes them: the Drupal database, Syslog, a file, or a cloud log collector; the README recommends the Extended Logger + Extended Logger DB modules for local viewing and production-grade log scrapers otherwise. A separate OpenTelemetry path (enabled only when the `opentelemetry` and/or `opentelemetry_metrics` contrib modules are installed) exports each AI request as a span named "AI provider request" with the same attributes, and token usage as counter metrics (meter `ai_observability.token_usage`, metric prefix `ai_token_usage`, broken down by uid/provider/operation_type/model). Everything is driven from one settings form at `/admin/config/ai/observability` (route `ai_observability.settings`, permission `administer ai observability`); config lives in `ai_observability.settings`. Logging of raw input and output is off by default so prompts and responses are not persisted unless you opt in. A `fallback_log_message_mode` toggle switches between Drupal-style and PSR-3-style message placeholders so the output is compatible with either the core logger or a structured logger. It defines no plugin types, entities, or Drush commands — it is purely an event-driven telemetry layer over AI Core.

---

- Log every AI provider request and response to the Drupal Logger for an audit trail.
- Track token usage per request, provider, model, and operation type.
- Attribute AI token consumption to individual users (the OTEL metrics carry a `uid`).
- Build aggregated cost/usage reports and charts from the emitted logs or metrics.
- Enforce or monitor per-user, per-week token budgets using the logged usage data.
- Export AI requests as OpenTelemetry spans to a tracing backend (Jaeger, Tempo, etc.).
- Export token usage as OpenTelemetry counter metrics to Prometheus-style collectors.
- Debug which provider, model, and operation type served a given request.
- Correlate multi-step AI calls via `provider_request_id` and `provider_request_parent_id`.
- Optionally capture the exact input prompt text sent to the provider for review.
- Optionally capture the provider's output/response for review.
- Record guardrail results applied to a request alongside the log entry.
- Limit logging to specific tagged requests via the log-tags filter.
- Choose exactly which event types to log (pre-generate, post-generate, post-streaming, provider-disabled).
- Log when an AI provider is disabled (`ProviderDisabledEvent`).
- Send AI logs to Syslog, a file, or a cloud log collector by configuring Drupal's logger.
- Store and browse AI logs locally using the Extended Logger + Extended Logger DB modules.
- Keep log entries small and fast by using PSR-3 placeholders with a structured logger.
- Stay compatible with the core Drupal Logger by keeping the Drupal-style placeholder fallback on.
- Capture streaming chat completions once finished via `PostStreamingResponseEvent`.
- Add input/output as span attributes for deep per-request tracing when needed.
- Monitor AI usage for transparency and compliance reporting.
- Turn AI logging on or off site-wide with a single settings toggle.
- Restrict who can change observability settings via the `administer ai observability` permission.
- Provide the telemetry foundation for cost dashboards built on top of AI Core.
