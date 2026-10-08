<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools — settings, scopes, modes and webhooks

## Install / enable

`composer require drupal/mcp_tools` (pulls `mcp/sdk`, `code-wheel/mcp-*`, `enshrined/svg-sanitize`),
then `drush en mcp_tools -y`. Enables `tool`, `dblog`, `update` as dependencies. Configure at
`/admin/config/services/mcp-tools` (route `mcp_tools.settings`, `SettingsForm`, permission
`administer site configuration`). Status page at `.../status` (`StatusController`).

## Config object `mcp_tools.settings`

Schema `config/schema/mcp_tools.schema.yml`, defaults `config/install/mcp_tools.settings.yml`. Key
groups:

- **`mode`**: `development` | `staging` | `production` | `custom` — a preset applied by the form to
  the settings below.
- **`access`** (consumed by `AccessManager`):
  - `read_only_mode` (bool) — blocks ALL write/trigger operations site-wide.
  - `config_only_mode` (bool) + `config_only_allowed_write_kinds` (list of `config`/`content`/`ops`,
    default `[config]`) — restricts which write *kinds* are allowed when set.
  - `allowed_scopes` (default `[read, write]`) — hard ceiling on grantable scopes.
  - `default_scopes` (default `[read]`) — used when a connection specifies none.
  - `trust_scopes_via_header` (false), `trust_scopes_via_query` (false), `trust_scopes_via_env`
    (true) — whether `X-MCP-Scope` / `?mcp_scope` / `MCP_SCOPE` may raise scopes. Client-controlled
    sources are OFF by default by design.
  - `audit_logging` (true).
- **`rate_limits`** (expensive reads: `broken_link_scan`, `content_search`) and **`rate_limiting`**
  (writes: `enabled` false, `trust_client_id_header` false, per-minute/hour/delete/structure caps).
  Enforced by `Service/RateLimiter` via `AccessManager::canWrite()/canAdmin()`.
- **`allowed_hosts`** — SSRF allowlist for URL-fetching tools (default `localhost`, `*.local`).
- **`output`**: `max_items` (100), `include_sensitive` (false).
- **`webhooks`**: `enabled`, `url`, `secret`, `allowed_hosts`, `timeout`, `batch_notifications`,
  `notify_on` — see below.

## Scopes recap

Three scopes: `read`, `write`, `admin` (`AccessManager::SCOPE_*`). Effective scope for a request =
`programmatic setScopes()` (set by transports) OR the trusted header/query/env source, intersected
with `allowed_scopes`, else `default_scopes`. `hasScope()` drives per-tool checks;
`canWrite()/canAdmin()` additionally enforce read-only mode and rate limits.

## Webhook notifications (`Service/WebhookNotifier`)

When `webhooks.enabled` and a `url` are set, MCP write operations POST a JSON payload
(`operation`, `entity_type/id`, acting user, sanitized `details`). Notable properties:
- Payload details are redacted for sensitive keys (`sanitizeDetails()`).
- If `webhooks.secret` is set, an `X-MCP-Signature: sha256=<hmac>` header is added.
- **SSRF-guarded**: `validateWebhookUrl()` rejects non-http(s) schemes, a blocklist of
  loopback/metadata hosts, and hosts resolving into private/reserved ranges; redirects are
  re-validated per hop via Guzzle `on_redirect`. Optional `allowed_hosts` allowlist (wildcards).

## Server profiles `mcp_tools_servers.settings`

`ServerConfigRepository` reads named server profiles (`servers`, `default_server`) with per-profile
`scopes`, `transports` (`http`/`stdio`), `gateway_mode`, `include_all_tools`, `enable_resources`,
`enable_prompts`, and an optional `permission_callback` (service:method or callable resolved from
the container). Transports select a profile by id; `checkAccess()` and `allowsTransport()` gate use.
