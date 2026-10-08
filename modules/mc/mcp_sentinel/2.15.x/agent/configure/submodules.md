<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel submodules

Three optional submodules ship in the project (each `^10.6 || ^11.3`):

## `mcp_sentinel_approval` — human approval gate
Depends only on `mcp_sentinel`. Queues governed destructive operations (e.g. bulk delete) as approval-request
entities for a human to approve/deny. Config: `/admin/config/services/mcp-sentinel/approval`
(`mcp_sentinel_approval.settings`). Decisions at `/admin/reports/mcp-sentinel/approvals/{id}/approve|deny`
(permission `approve mcp sentinel operations`, `restrict access`). Since 2.11 approval **binds to one HMAC-sealed
`McpActionManifest`**: the seal is re-checked, expiry enforced, the live target uuid/revision must still match, the
idempotency key is consumed once, and the requester cannot approve their own request. Provides a **break-glass**
mechanism (`drush mcp-sentinel:break-glass`) granting a time-boxed, HMAC-sealed, single-use `mcp_admin` role — refused
for uid 1, existing `is_admin` accounts, a missing signing key, or a role holding permissions outside
`McpBreakGlassManager::ALLOWED_PERMISSIONS`. Ships a non-admin `mcp_admin` role in `config/optional`.

## `mcp_sentinel_graphql` — GraphQL governance
Depends on `mcp_sentinel`, `graphql`, `graphql_compose`. Extends governance to the GraphQL Compose endpoint:
mutation gating, field redaction (over-ceiling/redacted fields become `[REDACTED]`), DLP scanning of field results,
audit, and schema-discovery tool. Requests are subject to the same read budgets and classification egress ceilings.

## `mcp_sentinel_server` — mcp_server registration
Depends on `mcp_sentinel` and `mcp_server:mcp_server_tool_bridge`. Registers the Sentinel Tool plugins with
`mcp_server` and wires OAuth scopes (`ToolScopeResolver`). Provides the setup/provisioning Drush commands
(`mcp-sentinel:setup`, `:agent-provision`, `:agent-reconcile`, `:teardown`). Production readiness and the default
`setup` path require `mcp_server:mcp_server_oauth`; a development-only option exists but can never report the
connector-facing contract as ready.
