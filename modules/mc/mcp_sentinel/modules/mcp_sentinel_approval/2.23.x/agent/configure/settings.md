<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Approval settings & configuration

## Enable
`drush en mcp_sentinel_approval`. Requires `mcp_sentinel`. On install it may create the `mcp_admin` role from
`config/optional/user.role.mcp_admin.yml` (only when absent).

## Settings — `mcp_sentinel_approval.settings` (form `McpApprovalSettingsForm`, route
`mcp_sentinel_approval.settings`, perm `administer mcp sentinel`, path `/admin/config/services/mcp-sentinel/approval`)
Config keys (config/install + schema):

- `gated_operations` (seq of string, default `[delete, config_import, module_disable]`) — operations that require
  human approval before executing. `McpApprovalGate::requiresApproval()` also **always** gates `grant_mcp_admin`
  regardless of this list.
- `break_glass_ttl_seconds` (int, default 3600) — lifetime of an `mcp_admin` grant; a cron reaper revokes it after.

## The `mcp_admin` break-glass role (`config/optional/user.role.mcp_admin.yml`)
A deliberately narrow, non-standing operator role, not for agents:
- `is_admin: false` — never superuser; permissions are enumerated.
- Its permission list IS the grant-time allowlist (`McpBreakGlassManager::ALLOWED_PERMISSIONS`) — keep them identical.
  Ships with `access administration pages`, `view the administration theme`, `access site reports`,
  `view mcp sentinel audit log`, `administer mcp sentinel`.
- No `approve mcp sentinel operations` (separation of duties — break-glass cannot rubber-stamp its own elevation),
  no escape-hatch permissions, no `administer site configuration` / `administer modules`.
- `McpBreakGlassManager::grant()` refuses if the role is missing, `is_admin`, or holds any permission outside the
  allowlist, and refuses uid 1 or any account already holding an is_admin role. A status-report ERROR flags extra
  permissions; a WARNING flags a narrower subset.

The `gated_operations` set and the role allowlist are the two governance knobs; the actual replay logic lives in the
services documented in `api/approval.md`.
