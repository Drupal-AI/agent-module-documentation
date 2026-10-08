<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel Server (mcp_sentinel_server) — agent index

Submodule of **MCP Sentinel** that bridges the Sentinel governed Tool plugins to the **MCP Server** module and wires
their OAuth scopes. Depends on `mcp_sentinel`, `mcp_server` (>= 2.0.0-beta3), and `mcp_server_tool_bridge`. Version
**2.29.1**. Core `^10.6 || ^11.3`, PHP `>=8.3`.

**No settings page.** Operated entirely through Drush. Production readiness requires `mcp_server_oauth`.

## What it provides
- **Drush** (`McpSentinelServerCommands`): `mcp-sentinel:setup` (register tools with required OAuth + exact derived
  scope), `mcp-sentinel:teardown` (unregister), `mcp-sentinel:agent-provision <tier> --env=<env>`,
  `mcp-sentinel:agent-reconcile`.
- **Hook**: `hook_mcp_server_tool_bridge_discovery_access` — delegates catalog visibility to each governed tool's
  `discoveryAccess()` (permission → readiness → IP → scope).
- **Event subscriber**: `McpAuthorizationAuditSubscriber` — records a bounded `denied_access` audit row (HTTP status
  and reason only) for an MCP Server authorization refusal. It listens for MCP Server's authorization-denied event,
  which no MCP Server release includes yet; until one does, the listener never runs (no behaviour, no risk).
- Registers each Sentinel Tool as an `mcp_tool_config` entity; scope per tool is derived by
  `McpToolScopeResolver` from the plugin's operation/domain, never hand-declared.

## Solution docs
- **Setup, teardown, agent provisioning** → `drush/commands.md`.

## 2.29.x notes
- Depends on `mcp_server (>=2.0.0-beta3)` plus `mcp_server_tool_bridge` (the Bridge has an independent 1.x version
  line; its version is not compared against the server's 2.x floor).
- 2.29.1 added the `denied_access` authorization-audit subscriber (inert until MCP Server emits the event).
- Unlike the base module, the server submodule's tests stay on PHP `>=8.3`.
