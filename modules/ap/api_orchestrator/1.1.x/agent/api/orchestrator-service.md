<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Orchestrator service, tokens, events & Drush

## Main service — `api_orchestrator.service` (`ApiOrchestratorService`)
- `createRequest(string $endpointId, array $data = []): EntityInterface` — primary entry point. Loads the endpoint and its effective service, `sanitizeDataArray($data)`, builds URL (`base_url` + token-replaced `path`, plus `http_build_query()` of processed query params for REST), headers (`RequestBuilderService::buildHeaders()` = service + endpoint headers + API-key header, tokens replaced), and body (GraphQL vs REST). Saves an `ApiRequest` (`in_queue`) with generated `curl_command` and `trace_id`, then executes directly or queues per `is_direct`. Throws `\InvalidArgumentException` if endpoint/service missing.
- `createGraphqlRequest($endpointId, $variables)` — alias of `createRequest`.
- `executeRequest(ApiRequest)` → delegates to `HttpExecutorService`.
- `queueRequest(ApiRequest)` → item `{request_id}` on queue `api_orchestrator_request`.
- `getQueueInfo()` / `getQueuePosition($id)` — queue depth and estimated wait.
- Encoder/decoder registry: `registerEncoder/registerDecoder`, `getEncoder/getDecoder` (default `json`); ships `json` + `graphql` encoders, `json` decoder (`src/Encoder/*`, `src/Decoder/*`).

## Direct-call client — `api_orchestrator.http_client` (`ApiHttpClientService`)
`request($serviceId,$method,$url,$options,$endpointId=null)` / `get()` / `post()` — thin Guzzle wrapper used by the ECA "direct request" action. When the service has `log_requests` (debug) enabled it creates/updates an `ApiRequest` entity so direct calls appear in the dashboards; optionally records a cURL command when `log_curl_commands` is on. Uses the shared Guzzle client (TLS verification on by default).

## Token syntax (`TokenReplacerService`)
- `{{name}}` — replaced from the `$data` array passed to `createRequest`.
- `{{name|default}}` — default when the key is absent.
- In GraphQL variable templates, `"{{name}}"` (quoted) is JSON-string-encoded; bare `{{name}}` is emitted as a number/bool for type-aware variables.
- Service `api_key` additionally supports the secure sources `{{env:…}}`, `{{state:…}}`, `{{config:…}}` (resolved in `ApiService::getApiKey()`).

## Events & hooks
- `Drupal\api_orchestrator\Event\ApiOrchestratorEvents::REQUEST_COMPLETED` → `ApiRequestCompletedEvent`; `::REQUEST_FAILED` → `ApiRequestFailedEvent($request, $errorMessage, $statusCode)`. Subscribe to react to outcomes.
- `hook_api_orchestrator_request_failed($request)` — invoked on permanent failure (consumed by the Notifications submodule).
- `ApiOrchestratorHooks`: `hook_cron` (retention cleanup), `hook_theme` (`api_orchestrator_dashboard`, `api_orchestrator_request`), `hook_mail` (`api_orchestrator_request_failed`).

## Drush (`ApiOrchestratorCommands`, `drush.services.yml`)
- `api-orchestrator:services` (`ag-services`) — list services (API-key presence shown as Yes/No).
- `api-orchestrator:endpoints [serviceId]` (`ag-endpoints`).
- `api-orchestrator:request <endpointId> --data='{"k":"v"}'` (`ag-request`) — create a request.
- `api-orchestrator:status <id>` (`ag-status`), `:retry <id>` (`ag-retry`), `:clear --status= --older-than=` (`ag-clear`, confirms), `:queue-info` (`ag-queue`).

## Code example
```php
/** @var \Drupal\api_orchestrator\Service\ApiOrchestratorServiceInterface $o */
$o = \Drupal::service('api_orchestrator.service');
$request = $o->createRequest('get_product_by_sku', ['sku' => 'ABC-123']);
// Queued endpoints run on cron; direct endpoints have $request->getResponseBody() populated.
```
