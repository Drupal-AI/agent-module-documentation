<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools MCP Server Bridge (mcp_tools_mcp_server) — agent index

Interoperability submodule of **MCP Tools**. Bridges MCP Tools' Tool API plugins into the contrib
**`drupal/mcp_server`** module by creating/updating `mcp_tool_config` entities, so the same tool
library is served through MCP Server. Depends on `mcp_tools` and `mcp_server`. One Drush command, no
routes/permissions/config. Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version dir 1.0.x
(installed 1.0.0-beta8).

- **The `mcp-tools:mcp-server-sync` command and what it writes** →
  [drush/sync.md](drush/sync.md)

## What it provides (from source)

- `src/Commands/McpToolsMcpServerCommands.php` — `sync()`
  (`#[CLI\Command('mcp-tools:mcp-server-sync')]`, alias `mcp-tools:mcp-server:sync`). Iterates
  `plugin.manager.tool` definitions with provider prefix `mcp_tools` and creates/updates
  `mcp_tool_config` entities whose `tool_id` is `tool_api:<mcp_name>` (MCP Server's generic
  `tool_api` plugin; `mcp_name` = plugin id with `:` → `___`). Config entity id is a machine-safed
  plugin id.
- `drush.services.yml` — injects `plugin.manager.tool`, `plugin.manager.mcp_server.tool`,
  `entity_type.manager`.

## Options

`--enable` (enable all synced) · `--enable-read` (enable only Read-operation tools) · `--auth-mode`
(`required`|`optional`|`disabled`, default `required`, for NEW configs) · `--update-existing`
(refresh `tool_id`/label, does not change scopes) · `--dry-run`. Guards: aborts if MCP Server's
`tool_api` plugin or the `McpToolConfig` entity class is absent.
