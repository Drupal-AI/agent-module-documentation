API Orchestrator is a Drupal 11 framework for defining external APIs as configuration entities and executing queued or direct REST/GraphQL requests through one orchestration service with retry logic, token replacement, logging, and events.

---

API Orchestrator replaces ad-hoc `curl`/Guzzle calls scattered across a codebase with a central integration layer. You model each external API as an **API Service** config entity (base URL, auth header + API key, timeout, retry policy) and each call as an **API Endpoint** config entity (path, method, headers, query parameters, body template, or a GraphQL query/variables/operation). Calling `ApiOrchestratorService::createRequest($endpointId, $data)` resolves `{{token}}` / `{{token|default}}` placeholders, builds the URL, headers and body, records an **API Request** content entity (with a trace ID, cURL command, timing and response metadata), and either executes it immediately (direct endpoints) or queues it for background processing by cron via the `api_orchestrator_request` queue worker (with per-service max-retries, retry interval and non-blocking rate limiting). Environments let one endpoint target different services per host. Completed/failed requests dispatch events and hooks that the Notifications and Alerts submodules consume, and a token-protected public health-check JSON endpoint lets external systems poll request status by trace ID. A family of submodules adds dashboards (Analytics, Monitoring), reporting/export, threshold Alerts, multi-channel Notifications, ECA no-code actions, response Mirroring, and ready-to-run sample integrations.

---

- Centralize all outbound API integrations behind one service instead of scattered `curl_init()` / Guzzle calls.
- Define a REST service and endpoints (GET/POST/PUT/PATCH/DELETE) entirely from the admin UI at `/admin/config/services/api-orchestrator`.
- Call a GraphQL API by storing the query, JSON variables template and operation name on an endpoint.
- Parameterize requests with `{{token}}` and `{{token|default}}` placeholders in URL paths, query strings, headers and JSON bodies.
- Queue high-volume or non-blocking requests for background processing on cron, with automatic retry on 5xx/429/connection errors.
- Execute latency-sensitive requests immediately by marking an endpoint as a direct call.
- Apply per-service or global timeout, max-retries and retry-interval policies.
- Keep API keys out of stored config by resolving them from environment variables (`{{env:VAR}}`), Drupal state (`{{state:key}}`) or config (`{{config:name.key}}`).
- Track each request end-to-end with a generated trace ID (`TRC-…`) for correlation with external systems.
- Debug failures using the auto-generated equivalent cURL command stored on each request.
- Store oversized API responses to private files automatically instead of bloating the database.
- Retry a permanently failed request manually from the admin UI or with `drush api-orchestrator:retry <id>`.
- Inspect, filter and clear request logs from the Requests collection or `drush api-orchestrator:clear`.
- List configured services and endpoints from the CLI (`drush api-orchestrator:services`, `:endpoints`).
- Expose a token-authenticated, rate-limited public health endpoint so external systems can poll request status by trace ID.
- Automatically purge old completed/failed request logs on cron by enabling retention cleanup.
- React to request completion/failure in custom code via `ApiRequestCompletedEvent` / `ApiRequestFailedEvent` or the `hook_api_orchestrator_request_failed` hook.
- Send failure notifications to Email, Slack, Microsoft Teams or WhatsApp (Notifications submodule).
- Raise threshold alerts (error rate, average duration, no-requests, success-rate drop) to Slack/Discord with cooldowns (Alerts submodule).
- Visualize traffic, latency and status-code distribution on Analytics and real-time Monitoring dashboards.
- Generate interactive HTML reports and export request data to CSV/Excel/PDF/JSON, including scheduled emailed reports.
- Trigger API requests from no-code ECA workflows and branch on API responses (ECA submodule).
- Mirror an external API response into a filterable, sortable local listing via dot-notation field mapping (Mirror submodule).
- Bootstrap quickly with the JSONPlaceholder, Shopify (mock.shop) or Magento GraphQL sample integrations.
