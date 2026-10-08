MCP Sentinel Server registers the MCP Sentinel governed Tool plugins with the MCP Server module, wires each tool's exact OAuth scope, and provisions per-environment agent tiers via Drush.

---

This submodule depends on `mcp_sentinel` and on mcp_server's Tool API bridge (`mcp_server:mcp_server_tool_bridge` >= 2.0.0-beta3). It is the piece that actually exposes the Sentinel tools to MCP clients: `drush mcp-sentinel:setup` preflights and registers each Sentinel Tool plugin as an `mcp_tool_config` entity, tagging every tool with the exact OAuth scope derived from the plugin's own declaration (`McpToolScopeResolver`: content read/write → `mcp_read`/`mcp_write`, config read/write → `mcp_config_read`/`mcp_config`), so scopes are never hand-declared and cannot drift from the code. Production readiness requires `mcp_server_oauth`; the only exception is an explicit `--allow-unauthenticated-development` escape that stays not-ready and exits non-zero. It has no settings page. `hook_mcp_server_tool_bridge_discovery_access` routes catalog visibility through each governed tool's own `discoveryAccess()` (permission + readiness contract + IP allowlist + scope). `mcp-sentinel:agent-provision`/`agent-reconcile` create the per-environment agent tiers (a role, a service account, and a designated OAuth Consumer) without ever creating or rotating a Consumer secret — those are set out of band.

---

- Expose the MCP Sentinel governed tools to an MCP client through the MCP Server module.
- Register every Sentinel tool with required OAuth by default (`drush mcp-sentinel:setup`).
- Tag each tool with the exact OAuth scope derived from the plugin, avoiding hand-maintained scope lists.
- Route MCP tool-catalog discovery through each tool's own readiness/scope/IP governance gate.
- Unregister all Sentinel tools from the MCP server (`drush mcp-sentinel:teardown`).
- Provision a content-tier agent (role + service account + OAuth consumer) for an environment (`agent-provision content --env=prod`).
- Provision other tiers: content-auditor, auditor, developer, or admin.
- Reconcile every declared agent tier at once from `agent_provision_tiers` (`agent-reconcile`).
- Keep Consumer secrets out of automation — the provisioning commands never create or rotate them.
- Refuse to report the connector-facing contract as ready when OAuth is not required (development escape exits non-zero).
- Ensure a stale Tool API bridge (which answers 200 with zero tools) is refused by requiring bridge >= 2.0.0-beta3.
- Bring the governed tools online only once the source-governance contract (server/bridge/OAuth/audit/tool registration) is complete.
