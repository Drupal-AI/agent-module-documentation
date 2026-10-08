<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel Server (mcp_sentinel_server) — agent index

Submodule of **MCP Sentinel** that bridges the Sentinel governed Tool plugins to the **MCP Server** module and wires
their OAuth scopes. Depends on `mcp_sentinel` and `mcp_server:mcp_server_tool_bridge` (>= 2.0.0-beta3). Version
**2.23.1**. Core `^10.6 || ^11.3`.

**No settings page.** Operated entirely through Drush. Production readiness requires `mcp_server_oauth`.

## What it provides
- **Drush** (`McpSentinelServerCommands`): `mcp-sentinel:setup` (register tools with required OAuth + exact derived
  scope), `mcp-sentinel:teardown` (unregister), `mcp-sentinel:agent-provision <tier> --env=<env>`,
  `mcp-sentinel:agent-reconcile`.
- **Hook**: `hook_mcp_server_tool_bridge_discovery_access` — delegates catalog visibility to each governed tool's
  `discoveryAccess()` (permission → readiness → IP → scope).
- Registers each Sentinel Tool as an `mcp_tool_config` entity; scope per tool is derived by
  `McpToolScopeResolver` from the plugin's operation/domain, never hand-declared.

## Solution docs
- **Setup, teardown, agent provisioning** → `drush/commands.md`.
