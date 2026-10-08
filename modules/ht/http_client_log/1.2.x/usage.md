<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Client Log records the outbound HTTP requests Drupal makes through `\Drupal::httpClient()` (core's Guzzle client) as content entities, storing each request's method, URL, headers and body alongside the response status, headers and body, with an admin listing, per-entry detail pages, and a settings form that filters what gets recorded.

---

The module works by decorating core's `http_client_factory` service (`HttpClientLogService`, a subclass of core `ClientFactory`) and pushing a Guzzle log middleware — from the `covergenius/guzzle_logger` library — onto the handler stack, so every client built by `\Drupal::httpClient()` is instrumented. After each transfer the middleware hands the request and response to a custom `Logger`, which runs a chain of filters and, when they pass, creates and saves an `http_client_log` content entity. The filters are configured at `/admin/config/services/http-client-logs`: a global on/off toggle; a URL allowlist or denylist of `fnmatch` wildcard patterns; a time-of-day window plus days-of-week; a request-method filter (GET/POST/PUT/DELETE/HEAD/PATCH); an "only log when a response exists" switch; a response-status filter (all / errors 4xx–5xx / successful 2xx); and a response `Content-Type` substring filter that defaults to `text/html`, `json`, `application/xml`. Entries are browsed through a View at `/admin/reports/http-client-logs` (gated by the module's administer permission) and each has a canonical detail page at `/admin/reports/http-client-logs/{id}` gated by entity `view` access; the settings route requires `administer site configuration`. `hook_cron` prunes the `http_client_log` table down to the configured retention limit (default 100,000 rows; "All" disables pruning). Because the store is a full copy of what the site sends and receives, it is operationally a sensitive dataset: outbound API calls carry Authorization headers, bearer tokens, API keys and request bodies, so the module is packaged as a Development tool — enable it for a targeted investigation, keep access to the log restricted, use the URL/method/status filters to narrow what is captured, and rely on the retention limit so the table does not grow without bound.

---

- Debug why a payment gateway call is being rejected by inspecting the exact request sent.
- See the precise payload a CRM sync transmitted to a third-party API.
- Investigate a 400/422 response by reading the response body the provider returned.
- Confirm that an integration is sending the header or auth token it should.
- Diagnose a data sync that produces the wrong records upstream.
- Capture an outbound request and response to attach to a support ticket.
- Verify the payload a module posts to an outgoing webhook endpoint.
- Trace an intermittent integration failure by reviewing recent client calls.
- Narrow logging to one provider with a URL allowlist pattern (e.g. `https://api.example.com/*`).
- Log only error responses (4xx/5xx) during a production incident window.
- Restrict capture to POST/PUT/DELETE to focus on state-changing calls.
- Limit logging to business hours or specific weekdays with the time filter.
- Record only JSON/XML API responses and skip HTML by tuning the Content-Type filter.
- Review what `\Drupal::httpClient()` requests migrations or feeds make against an API.
- Inspect response headers (rate-limit, cache, auth-challenge) returned by a service.
- Compare request headers across environments to explain differing API behaviour.
- Cap log growth on a busy site by setting a retention limit pruned on cron.
- Temporarily enable capture for a reproduction, then toggle logging off.
- Hand off an integration by showing a colleague real request/response examples.
- Confirm a `verify`/TLS or redirect option change altered the actual outbound call.
