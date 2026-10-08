<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands (approval submodule)

Provided by `McpApprovalCommands` (`modules/mcp_sentinel_approval/src/Drush/Commands/`):

- **`mcp-sentinel:break-glass <uid>`** (alias `mcps:break-glass`) — request break-glass elevation for a user. It does
  not grant directly: because `grant_mcp_admin` is always gated, the request is queued as an `mcp_approval_request`
  for a human holding `approve mcp sentinel operations` to approve. On approval, `McpBreakGlassManager::grant()`
  assigns the time-boxed `mcp_admin` role (lifetime = `break_glass_ttl_seconds`), which a cron reaper later revokes.
  Example: `drush mcp-sentinel:break-glass 5`.
