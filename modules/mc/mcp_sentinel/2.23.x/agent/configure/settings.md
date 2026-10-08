<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, policy profiles & config schema

## Install / enable
`composer require drupal/mcp_sentinel` then `drush en mcp_sentinel`. Hard deps (`audit_chain`, `tool`, `key`,
`simple_oauth`, `consumers`, `encrypt`) install with it. `hook_install` (`mcp_sentinel.install`) seeds an `mcp_api`
role with `access content`, `access user profiles`, `view media`, `access mcp sentinel context` — assign it to your
API user. Without `audit_chain` enabled, `hook_requirements` raises a status-report ERROR and governed writes are
refused rather than performed unaudited. To actually govern traffic you also enable `mcp_sentinel_server` and register
the tools (`drush mcp-sentinel:setup`).

## Global settings — `mcp_sentinel.settings` (form: `McpSettingsForm`, route `mcp_sentinel.settings`)
The form is organised into vertical tabs: MCP Access, OAuth agent channel, Audit Logging, DLP, Anomaly detection,
Reliable webhooks, Dashboard broadcast. Config object keys (config/install + config/schema `mcp_sentinel.schema.yml`):

- `enabled` (bool) — master MCP access switch. `health` returns 503 "disabled" when off.
- `governed_roles` (seq) — roles treated as governed (default `[mcp_api]`); `anonymous`/`authenticated` are never usable.
- `governed_role_fallback` (bool, default FALSE) — local-dev only: treat a governed role as governed even without an
  OAuth agent token. Off in production; governance then requires the real OAuth channel.
- `agent_oauth_clients` (seq) — consumer `client_id` values that mark the agent channel.
- `agent_scopes` (seq, default `mcp_read, mcp_write, mcp_config, mcp_config_read`) — token scopes that mark the channel.
- `audit_enabled` (bool), `audit_log_reads` (bool, default FALSE), `audit_retention_days` (int, default 90).
- `audit_sensitive_config_keys` (seq), `audit_secret_config_prefixes` (seq) — **add** to the built-in secret lists
  (cannot remove built-ins); values under these are never logged or returned.
- `require_finite_read_budgets` (bool, default TRUE) — clamps unlimited (0) profile budgets to `read_budget_defaults`.
  Disabling is a visible non-production override (status-report WARNING).
- `read_budget_defaults` (map) — `results` 500, `bytes` 8388608, `requests` 600 / `request_window` 60,
  `pages` 120 / `page_window` 60.
- `classification_labels` (seq, default `public, internal, restricted`), `classification_map` (seq of
  {entity_type, bundle, field, label}), `context_schema_label` (default `internal`). `user`, `oauth2_token`, `key`,
  `consumer`, `encryption_profile` are pre-labelled `restricted`.
- `dlp_enabled` (bool, default FALSE), `dlp_mask_mode` (`redact`|`partial`), `dlp_patterns` (seq of
  {label, regex, mask, classification}) — ships email/us_phone/ssn/credit_card patterns.
- `anomaly_enabled` (bool, default FALSE), `anomaly_alert_email`, `anomaly_alert_webhook`, `anomaly_alert_log`,
  off-hours schedule (`anomaly_hours_*`), and `anomaly_rules` (seq; signals `count`, `off_hours`, `bulk_read`).
- `webhook_endpoints` (seq of {id, label, url, secret_key, events, enabled, allow_internal}),
  `webhook_delivery_retention_days` (int, default 30). See `configure/reports.md`.
- `dashboard_broadcast` ({message, severity}) — operator banner on the dashboard.
- `agent_provision_tiers` (seq) — declared agent principals reconciled by `mcp-sentinel:agent-reconcile`.

Note: `audit_hash_key`, `siem_enabled`, `audit_encryption_profile` moved to `audit_chain.settings` in 2.0.0; the
Sentinel form still presents them and writes them only there. Legacy single-URL webhook keys were migrated to
`webhook_endpoints` by update hooks and dropped from schema.

## Policy profiles — `mcp_policy_profile` config entity
Class `Drupal\mcp_sentinel\Entity\McpPolicyProfile` (annotation `@ConfigEntityType`, `admin_permission =
"administer mcp sentinel"`). Collection `/admin/config/services/mcp-sentinel/profiles`; forms `McpPolicyProfileForm`
(add/edit) and `McpPolicyProfileDeleteForm`. The agent's role selects a profile (`McpPolicyResolver::resolve()`);
the role-less `default` profile is a fallback, not a production policy. Exported keys / accessors:

- Gates: `allow_read`, `allow_write`, `allow_delete` (default FALSE), `allow_graphql_mutations` (default FALSE),
  `allow_config_read`/`allow_config_write` (both FALSE), `allow_schemaless_config_write` (FALSE), `allow_raw_sql` (FALSE).
- Entity scope: `allowed_entity_types` (empty = all-but-denylist), `denied_entity_types` (default denies `user`,
  `oauth2_token`, `key`, `consumer`, `encryption_profile`, `mcp_tool_config`, `mcp_policy_profile`),
  `entity_rules` (per-type `allow_delete`/`allow_write`/`allow_publish` overrides).
- Redaction / limits: `redacted_fields` (default `pass`, `mail`), `rate_limit_requests`/`rate_limit_window`,
  `result_count_cap`, `response_size_cap`, `allowed_ips` (CIDR allowlist), `egress_ceilings` (per-surface: tool,
  context, jsonapi, graphql, drush).
- Publish / redirect: `deny_publish` (default TRUE), `max_moderation_state`, `deny_external_redirects` (default TRUE),
  `allowed_redirect_hosts`.
- Assurance: `forbidden_role_permissions` (escape-hatch permissions the governed role must not hold — default lists
  `bypass file gate`, `bypass node access`, `administer users`, `administer permissions`, `masquerade as any user`,
  `administer site configuration`), `acknowledged_role_permissions` (deliberate grants, `role_id:permission` or
  `role_id:permission@environment`), `evidence_required_actions` (`entity_write`, `entity_delete`).
- `denied_config_types` — config name prefixes an agent may not read/write.

The profile edit form shows a live plain-language policy summary. `weight` orders profile precedence.

Screenshot of the settings form:

![MCP Sentinel settings form](../../../../../../../screenshots/mcp_sentinel/2.23.x/settings-form.png)
