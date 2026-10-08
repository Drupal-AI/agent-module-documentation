<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: Smart Router (ai_provider_universal_router)

Source: `web/modules/contrib/ai_provider_universal/modules/ai_provider_universal_router/`. Human name
"AI Provider: Universal — Smart Router". Depends on the parent `ai_provider_universal` only (soft
couplings to `ai_provider_universal_factcheck`, `views`, and AI-core Guardrail sets). Package
AI Providers. Version 1.0.0-beta3.

## What it does

Exposes virtual **route** models. A route is an `ai_universal_route` config entity that names a set of
candidate models; at call time `RouteDecider` classifies the prompt as simple or complex and returns
the **cheapest capable** candidate for that tier, with failover when a server is over its usage limit.
Every decision is written to a metadata log for a savings report. The candidate pool and all routing
targets come from admin config — request/prompt content only nudges the complexity class and a
context-window fit filter, never the backend or its URL/credentials.

## Config entity `ai_universal_route` — `src/Entity/AiUniversalRoute.php`

id `ai_universal_route`, config_prefix `route` (config `ai_provider_universal_router.route.*`),
`admin_permission: 'administer ai providers'`, `AdminHtmlRouteProvider`. Admin UI under
`/admin/config/ai/providers/universal/routes[/add|/{id}|/{id}/delete]`. Forms `AiUniversalRouteForm`
(add/edit) + core `EntityDeleteForm`; list builder `AiUniversalRouteListBuilder`. Exported keys:
`operation_type`, `candidates[]` (model entity ids; empty = all models of the operation type),
`simple_tier` (default 2), `complex_tier` (default 4), `factcheck` (bool, default FALSE),
`factcheck_min_score` (default 0.7), `verifier_model`, `required_features[]`, `guardrail_set`.

## Config object `ai_provider_universal_router.settings`

- `classifier_model` — model used to classify prompt complexity (empty = heuristics only).
- `prompts.classifier`, `prompts.verifier` — optional prompt-template overrides (sprintf placeholders
  validated in `RouterSettingsForm`).

## Routes & permissions

Both custom routes are gated by `_permission: 'administer ai providers'`:
`ai_provider_universal_router.settings` (`RouterSettingsForm`) and
`ai_provider_universal_router.report` → `/admin/reports/ai-router-savings` (`RouterLogController::report`).
Entity CRUD routes inherit the same admin permission. The submodule defines **no permissions of its
own** — it reuses `administer ai providers` everywhere, including the two shipped Views
(`ai_router_decisions`, `ai_router_log`).

## Services / hooks / events

- `RouteDecider` (alias `ai_provider_universal_router.decider`) — resolves a route to a chosen model and
  logs the decision to the `ai_universal_router_log` table (route_id, operation_type, complexity,
  est_tokens, chosen_model, candidate count, est_cost, est_cost_worst — **no prompt text, no keys**).
- `ComplexityClassifier` — simple/complex classification (heuristic or one optional model call, tagged
  as an internal call so it does not inherit chatbot guardrails).
- `UsageLimitEnforcer` (alias `ai_provider_universal_router.limits`) — per-server daily request/token
  limits with grace + alert thresholds; dispatches `UsageThresholdEvent` (ALERT / EXHAUSTED). The parent
  provider consults this service before each call.
- `AiProviderUniversalRouterHooks` — entity insert/update/delete clear the AI provider cache when a
  route changes; `hook_views_data` exposes the log table.

## Install

`.install` creates the `ai_universal_router_log` table (id, timestamp, route_id, operation_type,
complexity, est_tokens, chosen_model, candidates, est_cost, est_cost_worst).
