<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp-tools:mcp-server-sync — bridge to drupal/mcp_server

## Enable

`drush en mcp_tools_mcp_server -y` — requires `mcp_tools` and the contrib `mcp_server` module.

## Command

`drush mcp-tools:mcp-server-sync [--enable] [--enable-read] [--auth-mode=required] [--update-existing] [--dry-run]`
(alias `mcp-tools:mcp-server:sync`). Implemented in `McpToolsMcpServerCommands::sync()`.

## What it does (source)

1. Guard: abort with an error if MCP Server's `tool_api` tool plugin is not registered, or if the
   `Drupal\mcp_server\Entity\McpToolConfig` class is missing (dependency absent).
2. Validate `--auth-mode` ∈ {`required`,`optional`,`disabled`}.
3. For each `plugin.manager.tool` definition that is a `ToolDefinition` with provider prefix
   `mcp_tools`:
   - `configId` = machine-safed plugin id; `toolId` = `tool_api:` + plugin id with `:` → `___`;
     `label` = tool label.
   - `shouldEnable` = `--enable`, or (`--enable-read` and the tool's operation is `Read`).
   - **Existing config**: with `--update-existing`, update `tool_id`/`mcp_tool_name` if changed;
     enable it if `shouldEnable` and currently disabled. Save unless `--dry-run`.
   - **New config**: create `mcp_tool_config` with `mcp_tool_name`, `tool_id`, `status`,
     `authentication_mode` = `--auth-mode`, empty `scopes`. Save unless `--dry-run`.
4. Print a summary: discovered / created / updated / enabled counts (and a dry-run note).

## Notes

- New configs default to `authentication_mode: required` and `status` off unless you pass an
  enable flag — safe by default.
- `--update-existing` never changes an existing config's `scopes` (those are managed in MCP Server).
- Execution still runs through MCP Server's transport and auth; the parent module's per-tool
  `mcp_tools use <category>` permission + scope checks apply when a synced tool executes.
