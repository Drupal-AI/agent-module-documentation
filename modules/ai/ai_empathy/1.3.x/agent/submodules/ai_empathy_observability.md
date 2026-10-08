<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Empathy Observability (ai_empathy_observability) — submodule

Exports each evaluation result as an **OpenTelemetry span** for external observability backends. Depends
on `ai_empathy` + `opentelemetry`. No routes, no config object, no permissions. Ships a Grafana dashboard
template at `grafana/ai-empathy-observability.json`.

## Mechanism

- `AiEmpathyObservabilityHooks::entityInsert()` fires on every `ai_empathy_result` insert and calls
  `EvaluationSpanEmitter::emit()` (`src/Service/EvaluationSpanEmitter.php`).
- `emit()` gets the tracer from `@opentelemetry` (`OpentelemetryServiceInterface::getTracer()`; no-op if
  null), starts span `ai_empathy.evaluation`, and sets attributes: scenario_id, run_number, provider,
  model, the four metric scores, and system-cost fields (latency_ms, output_tokens, tokens_per_sec,
  peak_rss_mb, energy_j), plus benchmark_id and any present extra metric (tone_alignment/accountability/
  trust). It ends the span in a `finally`, and wraps everything in try/catch so **observability can never
  break an evaluation** (errors go to `logger.channel.ai_empathy_observability`).
- Span attributes are only **metric scores and identifiers** — no raw prompts, no response text, no API
  keys, no user PII. Provider/model are configured names, not secrets. The OTLP endpoint and its TLS are
  owned by the `opentelemetry` module's configuration; this submodule ships no HTTP call of its own.
