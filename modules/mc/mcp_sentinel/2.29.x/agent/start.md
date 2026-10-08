<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel (mcp_sentinel) — agent index

**Enterprise governance for AI-agent access to Drupal** over MCP / JSON:API / GraphQL: per-role policy profiles,
operation gates, entity allow/deny lists, field redaction, opt-in DLP, per-surface classification egress ceilings,
finite read budgets, exfiltration caps, IP allowlists, publish/moderation gates, governed scheduled publishing,
open-redirect guard, tamper-evident audit logging (via `audit_chain`), content locks, reliable HMAC webhooks, and
anomaly detection. Version **2.29.1** (branch 2.29.x). Core `^10.6 || ^11.3`, PHP `>=8.2`.

Hard deps: `audit_chain`, `tool`, `key`, `simple_oauth`, `consumers`, `encrypt`, plus core `user`, `node`, `jsonapi`.
Provides permissions, Drush commands, and config schema. Config entity: `mcp_policy_profile`. No plugin *types* of its
own; it ships `tool` Tool plugins and Validation constraints.

**Security-positive, fail-closed control plane.** A request is governed only when a validated OAuth token resolves to
the agent channel (designated consumer or agent scope) — decided server-side in `McpOauthContext`, never from a header.
A short-lived, client-bound **sealed token** (`mcs1.` prefix, `McpSealedTokenManager`) is a second agent channel,
accepted only where the non-global `mcp_sealed_token` auth provider is listed in a route's `_auth`. Cookie-session/admin
traffic is untouched. Governed product paths refuse until the source-governance contract (server/bridge/OAuth/audit/Tool
registration + a designated consumer bound to a role profile) is complete (`McpGovernanceReadiness`). Protection still
depends on **configuring restrictive profiles**, labelling data and setting egress ceilings, verifying redaction
coverage, securing keys, and monitoring the log.

## Routes
- Settings form: `/admin/config/services/mcp-sentinel` (`mcp_sentinel.settings`, perm `administer mcp sentinel`).
- Policy profiles: `/admin/config/services/mcp-sentinel/profiles` (`mcp_policy_profile` collection).
- Sealed tokens: `/admin/config/services/mcp-sentinel/tokens` (+ `/tokens/reveal` copy-once, `/tokens/{jti}/revoke`),
  all perm `administer mcp sentinel`.
- Dashboard: `/admin/reports/mcp-sentinel` + `/verify`, `/audit`, `/export`, `/webhooks`, `/webhooks/{delivery}/replay`,
  `/webhooks/prune`, `/banner-dismiss`.
- Agent endpoints: `/drupal-mcp/context` (`_auth: oauth2 | mcp_sealed_token`, perm `access mcp sentinel context`),
  `/drupal-mcp/readiness` (same auth, authenticated-only), `/drupal-mcp/health` (public uptime probe, status only).

## Solution docs
- **Settings, policy profiles, config keys & schema** → `configure/settings.md`.
- **Dashboard, audit log, webhook admin, sealed tokens, banner** → `configure/admin.md`.
- **Governance model, services, hooks, Tool plugins, /drupal-mcp endpoints & access** → `api/governance.md`.
- **Drush commands** (`status`, `verify`, `audit-verify`, `role-audit`, `sql-query`, `audit-purge`, `lock-clear`,
  `webhook-prune`, `webhook-replay`) → `drush/commands.md`.
- **Permissions** → `permissions/permissions.md`.

## Submodules (own doc trees under `modules/<sub>/2.29.x/`)
- `mcp_sentinel_approval` — human-in-the-loop approval gate + time-boxed break-glass elevation.
- `mcp_sentinel_graphql` — GraphQL Compose governance (mutation gating, redaction, DLP, result caps, audit).
- `mcp_sentinel_server` — registers Sentinel Tool plugins with `mcp_server`, wires OAuth scopes, provisions agent tiers.

## 2.29.x notes (since 2.23.x)
- **Sealed tokens** (2.27.0): an admin mints a short-lived (15m–24h), revocable bearer bound to a designated consumer
  and shown once at `/tokens/reveal`. The DB stores a SHA-256 hash only; the HMAC material is site-local
  (`hash_salt` + private key), never config. `verify()` re-checks signature, expiry, revoke flag, token hash,
  designated client, and the live consumer/owner. An admin MCP **status strip** appears on the dashboard and settings.
- **Governed scheduled publishing** (2.28.0): new profile setting `allow_scheduled_publish` (default FALSE, per-type
  override) decides scheduled publish/unpublish when `scheduler_content_moderation_integration` is installed, instead
  of the role's transition permissions. `deny_publish` still refuses an immediate publish.
- **Draft component edits** (2.29.0): a governed node draft PATCH can carry `meta.mcp_components` to change referenced
  paragraphs in the same save; `open_draft`/`draft_components` advertised in the translation inventory.
- **Denial explain** (2.27.0): Tool/readiness denials name the rule and whether widening access would change the
  result (`McpDenyExplainer`); text never includes secrets.
- PHP floor is now `>=8.2` for the base module and approval services (`composer.json`); only `mcp_server` /
  `mcp_sentinel_server` tests stay on 8.3.
