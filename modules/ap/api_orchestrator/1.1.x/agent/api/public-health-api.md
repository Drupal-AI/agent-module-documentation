<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Public health-check API — `PublicApiController`

Lets external systems poll request status without a Drupal login. Disabled by default.

## Routes (`api_orchestrator.routing.yml`)
- `GET /api/api-orchestrator/health` → `PublicApiController::healthCheck` — `_access: 'TRUE'` (auth enforced inside the controller).
- `OPTIONS /api/api-orchestrator/health` → `::options` — CORS preflight, returns 204 with permissive CORS headers.

## Authentication & limits (all from `api_orchestrator.settings`)
1. If `public_api_enabled` is falsy → 403 `API_DISABLED`. (No default in shipped config, so effectively off until enabled.)
2. Token: `?token=` compared to `public_api_token` with `hash_equals()`; empty/mismatch → 401 `UNAUTHORIZED`.
3. Rate limit: when `public_api_rate_limit > 0`, uses core `flood` keyed by client IP over a 60s window (`api_orchestrator.public_api`); over limit → 429 `RATE_LIMITED`.
The settings form requires a token ≥16 chars when the API is enabled.

## Query parameters
- `traceId` — fetch one request. Accepts the `TRC-…` format (matched on `trace_id`) or a numeric legacy id (matched on primary key `id`); other formats → 400 `BAD_REQUEST`.
- Otherwise a list is returned, filtered by optional `service` and `status` (validated against the four status constants), limited by `limit` (default 10, max 100), newest first.

## Response shape (GraphQL-style)
Success: `{ "data": { "healthCheck": { … } } }`. For a list: `requests[]` (each: traceId, id, service, endpoint, method, status, responseCode, duration, retryCount, timestamps; `errorMessage` for failed), `count`, `stats` (overall + last-hour aggregates via parameterized `SUM(CASE …)` queries), `timestamp`. Errors: `{ "errors": [{message, extensions:{code,…}}], "data": null }` with the matching HTTP status. All responses carry CORS headers (`Access-Control-Allow-Origin: *`) and `Cache-Control: no-store`.

Note: responses expose request **metadata** (service/endpoint ids, URL, status, response codes, error messages) — not stored response bodies.
