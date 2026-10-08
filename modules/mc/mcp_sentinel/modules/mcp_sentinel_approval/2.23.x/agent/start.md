<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel Approval (mcp_sentinel_approval) — agent index

Optional submodule of **MCP Sentinel**. Adds a human-in-the-loop gate: governed destructive operations by an AI agent
are queued as `mcp_approval_request` entities for a human to approve or deny, instead of running immediately. Also
manages a time-boxed, non-standing `mcp_admin` **break-glass** role for incident response. Depends only on
`mcp_sentinel`. Version **2.23.1**. Core `^10.6 || ^11.3`.

## What it provides
- **Content entities**: `mcp_approval_request` (base table `mcp_approval_request`) and `mcp_admin_grant`
  (`mcp_admin_grant`), both with `admin_permission = "approve mcp sentinel operations"` and admin route providers.
- **Permission**: `approve mcp sentinel operations` (restrict access).
- **Routes**: settings `/admin/config/services/mcp-sentinel/approval`; decisions
  `/admin/reports/mcp-sentinel/approvals/{mcp_approval_request}/approve` and `/deny`; entity collections
  `/admin/reports/mcp-sentinel/approvals` and `/admin/reports/mcp-sentinel/grants`.
- **Services**: `gate` (which ops require approval), `executor` (replays an approved op), `break_glass`
  (grant/revoke the role), `manifest_binder` (binds a decision to one sealed manifest), `reviewer_context` (sealed-vs-live
  diff), plus event subscribers for the base module's destructive-op/action events and break-glass conduct.
- **Tool plugin**: `mcp_sentinel_my_approvals` (read; an agent sees its own pending requests).
- **Drush**: `mcp-sentinel:break-glass <uid>`.

## Solution docs
- **Gated operations, break-glass TTL, config** → `configure/settings.md`.
- **Entities, gate, executor, break-glass, events, self-approval model** → `api/approval.md`.
- **Permission** → `permissions/permissions.md`.
- **Drush** → `drush/commands.md`.
