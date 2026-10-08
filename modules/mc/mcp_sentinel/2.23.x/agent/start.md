<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel (mcp_sentinel) — agent index

**Enterprise governance for AI-agent access to Drupal** over MCP / JSON:API / GraphQL: per-role policy profiles,
operation gates, entity allow/deny lists, field redaction, opt-in DLP, per-surface classification egress ceilings,
finite read budgets, exfiltration caps, IP allowlists, publish/moderation gates, open-redirect guard, tamper-evident
audit logging (via `audit_chain`), content locks, reliable HMAC webhooks, and anomaly detection. Version **2.23.1**
(branch 2.23.x). Core `^10.6 || ^11.3`, PHP `>=8.3`.

Hard deps: `audit_chain`, `tool`, `key`, `simple_oauth`, `consumers`, `encrypt`, plus core `user`, `node`, `jsonapi`.
Provides permissions, Drush commands, and config schema. Config entity: `mcp_policy_profile`. No plugin *types* of its
own; it ships `tool` Tool plugins and Validation constraints.

**Security-positive, fail-closed control plane.** A request is governed only when a validated OAuth token resolves to
the agent channel (designated consumer or agent scope) — decided server-side in `McpOauthContext`, never from a header.
Cookie-session/admin traffic is untouched. Governed product paths refuse until the source-governance contract
(server/bridge/OAuth/audit/Tool registration + a designated consumer bound to a role profile) is complete
(`McpGovernanceReadiness`). Protection still depends on **configuring restrictive profiles**, labelling data and setting
egress ceilings, verifying redaction coverage, securing keys, and monitoring the log.

## Routes
- Settings form: `/admin/config/services/mcp-sentinel` (`mcp_sentinel.settings`, perm `administer mcp sentinel`).
- Policy profiles: `/admin/config/services/mcp-sentinel/profiles` (`mcp_policy_profile` collection).
- Dashboard: `/admin/reports/mcp-sentinel` + `/verify`, `/audit`, `/export`, `/webhooks`, `/webhooks/{delivery}/replay`,
  `/webhooks/prune`, `/banner-dismiss`.
- Agent endpoints: `/drupal-mcp/context` (OAuth, perm `access mcp sentinel context`), `/drupal-mcp/readiness`
  (OAuth, authenticated-only), `/drupal-mcp/health` (public uptime probe, status only).

## Solution docs
- **Settings, policy profiles, config keys & schema** → `configure/settings.md`.
- **Dashboard, audit log, webhook admin, banner** → `configure/admin.md`.
- **Governance model, services, hooks, Tool plugins, /drupal-mcp endpoints & access** → `api/governance.md`.
- **Drush commands** (`status`, `verify`, `audit-verify`, `role-audit`, `sql-query`, `audit-purge`, `lock-clear`,
  `webhook-prune`, `webhook-replay`) → `drush/commands.md`.
- **Permissions** → `permissions/permissions.md`.

## Submodules (own doc trees under `modules/<sub>/2.23.x/`)
- `mcp_sentinel_approval` — human-in-the-loop approval gate + time-boxed break-glass elevation.
- `mcp_sentinel_graphql` — GraphQL Compose governance (mutation gating, redaction, DLP, result caps, audit).
- `mcp_sentinel_server` — registers Sentinel Tool plugins with `mcp_server`, wires OAuth scopes, provisions agent tiers.

## 2.23.x notes
- Composer pins `drupal/tool` to `^1.0.0-beta8` (was `*`); `mcp_sentinel_server` requires `mcp_server_tool_bridge` >= 2.0.0-beta3.
- Governed config-save audit and `mcp_sentinel_config_get` mask secret-bearing config values at any depth; two new
  settings, `audit_sensitive_config_keys` and `audit_secret_config_prefixes`, extend (never shrink) the built-in lists.
- Governed draft continuation covers `node`, `media`, and `paragraph` JSON:API resources (added by `McpDraftRoutes`).
