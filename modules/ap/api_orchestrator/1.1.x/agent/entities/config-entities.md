<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entities & the request lifecycle

All routes/forms below require `administer api orchestrator`. Base path `/admin/config/services/api-orchestrator`.

## `api_orchestrator_service` (`ApiService`, config_prefix `api_orchestrator_service`)
External API definition. `config_export`: `base_url`, `api_key`, `api_key_header` (default `X-API-Key`), `additional_headers`, `timeout`, `max_retries`, `retry_interval`, `notification_enabled`/`notification_type`/`notification_email`, `log_curl_commands`, `log_requests`, `use_global_settings`, `notification_providers`.
- `getApiKey()` resolves secure tokens on the stored value: `{{env:VAR}}`, `{{env:VAR|default}}`, `{{state:key}}`, `{{config:name.key}}` — otherwise returns the literal string.
- `getTimeout()/getMaxRetries()/getRetryInterval()` read the global `api_orchestrator.settings` when `use_global_settings` is TRUE, else the entity's own values (clamped).
- `additional_headers` accept a `Key: Value`-per-line string or JSON; `set()` normalizes to an array.
- Forms: `ApiServiceForm` (add/edit), `EntityDeleteForm`. Collection `entity.api_orchestrator_service.collection`.

## `api_orchestrator_endpoint` (`ApiEndpoint`, config_prefix `api_orchestrator_endpoint`)
A single call on a service. `config_export` includes `service_id`, `path`, `method`, `headers`, `query_parameters`, `body_template`, `is_graphql`, `is_direct`, `graphql_query`, `graphql_variables`, `graphql_operation_name`, `encoder_type`, `decoder_type`, `notification_providers`, `service_overrides`.
- `is_direct` TRUE → executed immediately in `createRequest()`; FALSE → queued.
- `getEffectiveServiceId()` picks `service_overrides[<env>]` for the detected environment, else `service_id`.
- `detectEnvironment()` matches the current host against each environment's `url_pattern` (case-insensitive equality), else the default environment id (or `local`).
- Form `ApiEndpointForm`.

## `api_orchestrator_environment` (`ApiEnvironment`, config_prefix `environment`)
Deploy target. Fields: `is_default`, `weight`, `url_pattern`. Install ships `dev`, `test`, `live` (all `url_pattern: ''`). Form `ApiEnvironmentForm`.

## `api_orchestrator_request` (`ApiRequest`, content entity, base table `api_orchestrator_request`)
Immutable log of one execution. Base fields (see `_api_orchestrator_request_fields()` in `.install`): `trace_id`, `service_id`, `endpoint_id`, `url`, `method`, `headers` (JSON), `body`, `status`, `retry_count`, `next_retry`, `response_code`, `response_body`, `error_message`, `curl_command`, `duration_ms`, `response_size`, `started_at`/`completed_at` (float microtime), `created`/`changed`. Status constants `STATUS_IN_QUEUE|PROCESSING|COMPLETED|FAILED`. Indexes on status, next_retry, service_id, endpoint_id, response_code, created, duration_ms, trace_id, and composite `(service_id,status,created)`.
- Routes: collection, canonical (`RequestViewController::view`, id `\d+`), delete, `request_retry` (`RequestController::retry`), `request_clear_confirm` (`RequestClearForm`), `response_download` (`ResponseDownloadController::download`).
- `ensureTraceId()` generates `TRC-<hex time>-<hex random>`.

## Lifecycle (see also `../api/orchestrator-service.md`)
1. `ApiOrchestratorService::createRequest($endpointId, $data)` loads endpoint + effective service, sanitizes `$data`, replaces tokens in path/query/headers/body, generates the cURL command and trace id, saves the `ApiRequest` as `in_queue`.
2. Direct endpoints → `HttpExecutorService::executeRequest()` immediately; queued endpoints → item `{request_id}` on queue `api_orchestrator_request`.
3. `ApiRequestQueueWorker::processItem()` (cron, 60s) rate-limits (requeues if interval unmet), sets `processing`, calls the executor.
4. `HttpExecutorService` sends via Guzzle (`http_errors=false`, `verify` from `ssl_verify` default TRUE), stores response (offloading bodies over `max_response_size` to files), and on 5xx/429/connection error re-queues up to `max_retries`, else marks `failed`, invokes `hook_api_orchestrator_request_failed` and dispatches `REQUEST_FAILED`. Success dispatches `REQUEST_COMPLETED`.
