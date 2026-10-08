<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure MCP Sentinel

**Settings form:** `/admin/config/services/mcp-sentinel` (route `mcp_sentinel.settings`, permission `administer mcp sentinel`).
**Dashboard:** `/admin/reports/mcp-sentinel`. **Audit log:** `/admin/reports/mcp-sentinel/audit` (+ `/export`).
**Webhook delivery log:** `/admin/reports/mcp-sentinel/webhooks`. Config object: `mcp_sentinel.settings`.

## Global settings keys (`mcp_sentinel.settings`)
- `enabled` (bool, default true) — master switch for governance.
- `governed_roles` (list, default `[mcp_api]`) — roles whose traffic is governed.
- `audit_enabled` / `audit_log_reads` / `audit_retention_days` (90) — audit logging (chain lives in `audit_chain`; the hash key + encryption profile are set on `audit_chain.settings`, edited from this form under Audit Logging).
- `webhook_enabled`, `webhook_endpoints` (map), `webhook_secret_key` (Key id for HMAC), `allow_internal_webhook_urls` (false), `webhook_delivery_retention_days` (30).
- `agent_oauth_clients`, `agent_scopes` (`mcp_read`, `mcp_write`, `mcp_config`, `mcp_config_read`), `agent_provision_tiers`, `governed_role_fallback` (false).
- `require_finite_read_budgets` (true — do NOT disable in production; false restores `0 = unlimited` and raises a permanent status warning) and `read_budget_defaults` (results 500, bytes 8 MiB, requests 600/60 s, pages 120/60 s).
- `classification_labels` (ordered `public < internal < restricted`), `classification_map` (rows labelling entity type/bundle/field; ships `user`, `oauth2_token`, `key`, `consumer`, `encryption_profile` = restricted), `context_schema_label` (internal).
- `dlp_enabled` (false), `dlp_mask_mode`, `dlp_patterns` (ships email/us_phone/ssn/credit_card; a row may declare a `classification` label to become a tighten-only detector).
- `anomaly_enabled`, `anomaly_alert_*`, `anomaly_hours_*` (off-hours schedule), `anomaly_rules` (denied-access storm, off_hours, bulk_read signals).
- `dashboard_broadcast` (operator banner).

## Policy profiles (config entity `mcp_policy_profile`)
Managed at the settings UI / `mcp_sentinel.mcp_policy_profile.*`. Ships a `default` profile. Per-profile keys:
`roles`, `allow_write`, `allow_delete`, `denied_entity_types`, `redacted_fields`, `allow_config_read`,
`allow_config_write`, `denied_config_types`, `deny_publish` (+ per-type `entity_rules.<type>.allow_publish`
override), `allow_raw_sql` (FALSE — gates `drush mcp-sentinel:sql-query`), `evidence_required_actions` (opt-in
`entity_write`/`entity_delete` require a keyed audit commit), `egress_ceilings` (highest label the profile may
receive per surface: `tool`, `context`, `jsonapi`, `graphql`, `drush`), `allowed_ips`, `deny_external_redirects`
(true) / `allowed_redirect_hosts`, `forbidden_role_permissions` / `acknowledged_role_permissions` (escape-hatch
guard — a governed role holding a forbidden permission fails `drush mcp-sentinel:role-audit`). The shipped `default`
profile denies the identity/credential entity types (`user`, `oauth2_token`, `key`, `consumer`,
`encryption_profile`, `mcp_tool_config`, `mcp_policy_profile`), redacts `pass`/`mail`, ships `allow_config_read` /
`allow_config_write` FALSE, and `deny_publish` TRUE.

## Endpoints (OAuth-authenticated, permission `access mcp sentinel context`)
- `GET /drupal-mcp/context` — MCP context/schema document (governed read: IP allowlist, request budget, attested
  bundle floor, and per-surface classification ceiling all apply before any schema is emitted).
- `GET /drupal-mcp/readiness` — source-contract readiness (no posture/effectiveness claim). Fail-closes uid 0 with
  403 JSON; an anonymous deny is rewritten to that JSON so a login-bounce cannot form (2.13.x).
- `GET /drupal-mcp/health` — public, unauthenticated liveness (`ok`/`disabled` + module name only, no data).
- `PATCH /jsonapi/node/<type>/<uuid>/mcp-draft` — **governed node draft continuation (2.15.0)**. Continues an
  existing unpublished forward revision; governed principals only. Requires `If-Match: "<live-rev>:<working-rev>"`
  (409 on mismatch, 400 on malformed). `X-MCP-Draft-Preflight: 1` validates without saving. Cannot publish, change
  the alias, change non-revisionable fields, or continue translated nodes. Carries the canonical JSON:API access +
  CSRF requirements plus the full write-precondition boundary.

A malformed/unknown bearer on `/drupal-mcp/*` (except health) returns JSON 401 with reason `unauthenticated`, not
the HTML 401 page (2.14.0).
