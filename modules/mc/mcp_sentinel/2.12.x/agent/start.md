<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel — agent index

**Enterprise governance for AI-agent access to Drupal** (policy profiles, per-surface egress ceilings, field
redaction, DLP, finite read budgets, tamper-evident audit logging, sealed-manifest human approval, portable attested
policy bundles, reliable webhooks) over MCP / JSON:API / GraphQL. Depends on `audit_chain`, `key`, `simple_oauth`,
`consumers`, `encrypt`, `tool`, `jsonapi`, `user`, `node`. Provides permissions and Drush commands. Version
**2.12.0**. Core `^10.6 || ^11.3`. PHP `>=8.3`.

**Security-positive** control plane — authenticates agents (Simple OAuth/Consumers), protects data (Key/Encrypt),
logs immutably (Audit Chain), redacts/DLP-filters fields. Traffic is governed only when a Consumer→OAuth principal
resolves to a role-bound profile; human traffic is untouched. Since 2.4 governed paths **fail closed** when the
source contract (server/bridge/OAuth/audit/Tool wiring) is incomplete; since 2.7 read budgets are **finite by
default**; since 2.11–2.12 an **attested policy-bundle floor** is consulted on the live access path and can arm an
emergency deny. Protection still depends on **policy configuration** — define restrictive profiles, label data and
set egress ceilings, verify redaction coverage, secure keys, monitor the log.

- **Configure** (settings, policy profiles, classification, egress ceilings, DLP, webhooks, break-glass): `/admin/config/services/mcp-sentinel` (`mcp_sentinel.settings`); dashboard at `/admin/reports/mcp-sentinel`. See `configure/settings.md`.
- **Drush** (status, verify, audit-verify, role-audit, governed sql-query, webhook replay/prune, agent provisioning): see `drush/commands.md`.
- **Permissions** (`administer mcp sentinel`, `view mcp sentinel audit log`, `access mcp sentinel context`, `approve mcp sentinel operations`): see `permissions/permissions.md`.
- **Submodules**: `mcp_sentinel_approval` (human approval gate), `mcp_sentinel_graphql` (GraphQL governance), `mcp_sentinel_server` (mcp_server registration + OAuth scopes). See `configure/submodules.md`.
