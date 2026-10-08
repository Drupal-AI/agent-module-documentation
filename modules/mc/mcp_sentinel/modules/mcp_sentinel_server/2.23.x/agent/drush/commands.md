<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands (server submodule)

Provided by `McpSentinelServerCommands` (`modules/mcp_sentinel_server/src/Drush/Commands/`). This submodule has no UI;
these commands are how it is operated.

- **`mcp-sentinel:setup`** (alias `mcps:setup`) — preflight and register every Sentinel Tool with the MCP server as an
  `mcp_tool_config` entity, tagging each with the exact OAuth scope derived from the plugin (`McpToolScopeResolver`).
  OAuth (`mcp_server_oauth`) is required by default. `--allow-unauthenticated-development` creates an explicit
  development-only, not-ready registration and exits non-zero (it can never report the connector-facing contract as
  ready). `--require-oauth` is accepted but is a no-op (OAuth is required unless the development escape is passed).
- **`mcp-sentinel:teardown`** (alias `mcps:teardown`) — unregister all Sentinel tools from the MCP server.
- **`mcp-sentinel:agent-provision <tier> --env=<env>`** (alias `mcps:provision`) — provision one agent tier
  (`content`, `content-auditor`, `auditor`, `developer`, or `admin`) as a role + service account + designated OAuth
  Consumer. **Consumer secrets are never created or rotated** by this command — set them out of band. Example:
  `drush mcp-sentinel:agent-provision content --env=prod`.
- **`mcp-sentinel:agent-reconcile`** (alias `msar`) — provision every tier declared in the `agent_provision_tiers`
  setting (each entry `"<tier>:<env>"`).

Required-bridge note: a `mcp_server_tool_bridge` older than 2.0.0-beta3 answers HTTP 200 with zero tools after the
plugin-directory move, so the dependency floor is enforced.
