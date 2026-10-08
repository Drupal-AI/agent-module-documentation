<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator (api_orchestrator) — agent index

Framework for managing external API integrations. Model APIs as config entities and run queued/direct REST/GraphQL requests through one service with retry logic, token replacement, request logging, events, and a public health API. Drupal `^11`, PHP `>=8.2`, no non-core dependencies. Lifecycle: experimental. All admin routes require the `administer api orchestrator` permission (restricted).

## What it provides

Config entities (admin UI at `/admin/config/services/api-orchestrator`):
- `api_orchestrator_service` (`ApiService`) — external API: `base_url`, `api_key` + `api_key_header`, `additional_headers`, `timeout`, `max_retries`, `retry_interval`, `use_global_settings`, notification settings. `getApiKey()` resolves `{{env:VAR}}`/`{{state:key}}`/`{{config:name.key}}` tokens.
- `api_orchestrator_endpoint` (`ApiEndpoint`) — a call on a service: `service_id`, `path`, `method`, `headers`, `query_parameters`, `body_template`, `is_graphql`+`graphql_query`/`graphql_variables`/`graphql_operation_name`, `is_direct` (immediate vs queued), `encoder_type`/`decoder_type`, `service_overrides` (per-environment).
- `api_orchestrator_environment` (`ApiEnvironment`, config_prefix `environment`) — deploy target matched by host `url_pattern`; one `is_default`.

Content entity:
- `api_orchestrator_request` (`ApiRequest`, base table `api_orchestrator_request`) — a logged request: service/endpoint ids, url, method, headers, body, `status` (in_queue/processing/completed/failed), `retry_count`, `response_code`, `response_body`, `error_message`, `curl_command`, `trace_id`, timing/size fields.

Services (`api_orchestrator.services.yml`): `api_orchestrator.service` (main — `ApiOrchestratorService::createRequest()`), `.http_executor` (`HttpExecutorService`, Guzzle exec + retry), `.http_client` (`ApiHttpClientService`, direct-call wrapper with optional logging), `.request_builder`, `.token_replacer`, `.response_storage`, logger channel `logger.channel.api_orchestrator`.

Plugins: QueueWorker `api_orchestrator_request` (`ApiRequestQueueWorker`); Encoder plugins (`json`, `graphql`) and Decoder plugins (`json`) registered in-code on the main service. Events `ApiOrchestratorEvents::REQUEST_COMPLETED`/`REQUEST_FAILED`; hooks `hook_cron` (retention cleanup), `hook_theme`, `hook_mail`, and invoked `hook_api_orchestrator_request_failed`. Drush commands (`api-orchestrator:services|endpoints|request|status|retry|clear|queue-info`).

Public route: `GET /api/api-orchestrator/health` (`_access: TRUE`, token enforced in `PublicApiController`).

## Solution docs
- [Global settings & config](config/settings.md) — `api_orchestrator.settings`, schema keys, public-API config.
- [Config entities & the request lifecycle](entities/config-entities.md) — service/endpoint/environment/request fields, queue vs direct, retry.
- [Orchestrator service, tokens, events & Drush](api/orchestrator-service.md) — `createRequest()`, token syntax, encoders/decoders, events/hooks, CLI.
- [Public health-check API](api/public-health-api.md) — token, rate limit, query params, response shape.

## Submodules (each documented under `modules/<name>/1.1.x/`)
`api_orchestrator_notifications` (Email/Slack/Teams/WhatsApp providers) · `api_orchestrator_alerts` (threshold alert rules → Slack/Discord) · `api_orchestrator_analytics` (charts dashboard) · `api_orchestrator_monitoring` (real-time dashboard) · `api_orchestrator_reports` (interactive HTML reports) · `api_orchestrator_export` (CSV/Excel/PDF/JSON + scheduled reports) · `api_orchestrator_eca` (ECA actions/conditions/events) · `api_orchestrator_mirror` (map API responses to a local listing) · `api_orchestrator_integration_samples` (container) · `api_orchestrator_sample_jsonplaceholder` · `api_orchestrator_sample_shopify` · `api_orchestrator_sample_magento` · `api_orchestrator_sample_alerts`.
