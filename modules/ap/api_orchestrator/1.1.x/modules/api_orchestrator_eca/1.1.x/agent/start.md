<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - ECA Integration (api_orchestrator_eca) — agent index

ECA actions/conditions/events for API Orchestrator. Depends on `api_orchestrator` and `eca`. Lifecycle: stable. No routes/permissions/entities/config of its own (help hook only).

## Provides (plugins under `src/Plugin/`)
- Actions:
  - `SendApiRequest` (id `api_orchestrator_send_request`) — runs a configured endpoint via `api_orchestrator.service::createRequest($endpointId, $tokenData)` (queued or direct per the endpoint).
  - `SendDirectApiRequest` (id `api_orchestrator_send_direct_request`) — raw HTTP call via `api_orchestrator.http_client` (`ApiHttpClientServiceInterface`): admin-configured `service_id`, `method`, `url`, `headers` (JSON), `body`, all token-replaced via ECA `tokenService->replaceClear()`. TLS verification on (shared Guzzle client).
- ECA conditions: `ApiResponseContains`, `ApiResponseStatusCode`, `ApiServiceExists` (`src/Plugin/ECA/Condition/`).
- ECA event: `ApiOrchestratorEvent` + `ApiOrchestratorEventDeriver` (`src/Plugin/ECA/Event/`) — derived from request completed/failed.
- `ApiOrchestratorEcaHooks::hook_help()`.

Note: `SendDirectApiRequest`'s URL/method are authored in the ECA model by a site builder (admin trust), not supplied by an end-user request.
