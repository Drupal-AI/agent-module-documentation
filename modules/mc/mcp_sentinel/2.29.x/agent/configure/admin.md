<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboard, audit log, webhook & sealed-token admin

Dashboard, audit log and webhook admin live under `/admin/reports/mcp-sentinel` (`mcp_sentinel.routing.yml`); the
sealed-token admin lives under `/admin/config/services/mcp-sentinel/tokens`. Local-task tabs join the dashboard,
audit log, and webhook deliveries.

## Governance dashboard — `McpDashboardController::dashboard`
`GET /admin/reports/mcp-sentinel` (perm `view mcp sentinel audit log`). Read-only console themed by
`mcp_sentinel_dashboard`: admin MCP status strip, urgent-conditions banner, posture rollup, status tiles,
chain-integrity card, top-agents and denied-by-policy panels, six charts, quick actions, active-controls strip. A
24h/7d/30d window toggle re-scopes counts and charts; widgets click through to the filtered audit log. Every widget is
built in its own try/catch so a failing metric degrades to `—` rather than fataling the page. Chart layout uses the
fixed-width `mcp_sentinel/charts` library so a single-chart row no longer fills the page. Data comes from `McpMetrics`,
`McpUrgentConditions`, and `McpChartRenderer` (inline SVG, upgraded to interactive charts when `drupal/charts` with a
library is present).

- **Verify chain now** — `McpDashboardController::verify`, `GET /admin/reports/mcp-sentinel/verify`
  (perm `administer mcp sentinel`, `_csrf_token: TRUE`). Re-runs the audit hash-chain check on demand.
- **Site-wide critical banner** — `hook_page_top` shows CRITICAL urgent conditions (e.g. broken hash chain,
  unresolvable signing key) on every admin route to `view mcp sentinel audit log` holders; it is inset by the admin
  navigation sidebar. Per-user dismissals go through `McpBannerController::dismiss` (`/banner-dismiss`, CSRF-protected);
  the banner reappears while the condition holds. A disclosed Audit Chain historical exception is a `historical_exception`
  warning rather than the critical `chain_broken` condition.

## Audit log — `McpAuditController`
- `listing`: `GET /admin/reports/mcp-sentinel/audit` (perm `view mcp sentinel audit log`). Filterable table
  (operation, entity_type, uid, from, to via `McpAuditFilterForm`), newest first, capped at 200 shown. Metadata is
  read through `McpAuditLogger::decodeMetadata()` (transparent at-rest decryption) and every value is HTML-escaped.
- `export`: `GET /admin/reports/mcp-sentinel/export?format=csv|json` (same perm). Streams up to 2000 rows, preserving
  the active filter query. Read-only export, not a state-changing route.

The trail itself is stored by `audit_chain` (table `audit_chain_log`) under the `mcp_sentinel` channel — hash-chained,
optionally HMAC-keyed, tamper-evident; `drush audit-chain:verify` / the dashboard verify action check it. Retention is
pruned on cron per `audit_retention_days`.

## Webhook deliveries — `McpWebhookDeliveryController`
Durable delivery log in table `mcp_sentinel_webhook_delivery` (defined in `mcp_sentinel.install`).

- `listing`: `GET /admin/reports/mcp-sentinel/webhooks` (perm `administer mcp sentinel`). Filter by `status` /
  `endpoint_id` (`McpWebhookFilterForm`); shows status badges and expandable payload/response (all escaped); up to 500 rows.
- `replay`: `GET /admin/reports/mcp-sentinel/webhooks/{delivery}/replay` (perm `administer mcp sentinel`,
  `_csrf_token: TRUE`, `delivery: \d+`). Resets a `failed*`/`sent` row to pending and re-enqueues.
- `prune`: `GET /admin/reports/mcp-sentinel/webhooks/prune` (perm `administer mcp sentinel`, `_csrf_token: TRUE`).
  Deletes rows past `webhook_delivery_retention_days`.

Delivery mechanics (`McpWebhookQueueManager` + `McpWebhookWorker` queue worker): endpoints are matched by event and
enabled flag; a pending delivery row stores the full payload for byte-identical replay; the item is queued. Delivery is
HTTPS-only with `verify => TRUE`, signed `X-MCP-Signature: sha256=<hmac>` when the endpoint declares a `secret_key`
Key entity (fail-closed `failed_key` if the key is missing/empty — never sent unsigned), never follows redirects
(`failed_redirect`), and runs a two-layer SSRF guard: a DNS-free check at enqueue and a DNS-resolving check at send
that pins the validated public IP via `CURLOPT_RESOLVE` (`failed_ssrf` on an internal target unless the endpoint
opts into `allow_internal`). Failed attempts back off exponentially and are re-queued on cron; permanent failures and
unresolvable signing keys surface on the status report.

## Sealed tokens — `McpSealedTokenController`
`GET /admin/config/services/mcp-sentinel/tokens` (perm `administer mcp sentinel`). Mint form (`McpSealedTokenMintForm`)
plus a table of minted tokens (jti, client, scopes, expiry, state) — the secret is never listed, only a hash is stored.
A sealed token is a short-lived (TTL 15m/1h/8h/24h), client-bound bearer for an agent that cannot complete the OAuth
flow; it is bound to a designated `agent_oauth_clients` consumer and mints under that consumer's active owner account
and scopes.

- `reveal`: `/tokens/reveal` (perm `administer mcp sentinel`, `no_cache`). Shows the minted secret **once** out of a
  per-admin private tempstore that expires after 120 seconds; the response is `private, no-store`
  (`McpSealedTokenRevealSubscriber` re-sets it after core's finish subscriber). A refresh or second visit shows only a
  "gone" message.
- `revoke`: `/tokens/{jti}/revoke` (perm `administer mcp sentinel`, `_csrf_token: TRUE`, `jti` a UUID). Marks a live
  row revoked; both mint and revoke are audited (`sealed_token_mint` / `sealed_token_revoke`). Cron prunes expired rows.
