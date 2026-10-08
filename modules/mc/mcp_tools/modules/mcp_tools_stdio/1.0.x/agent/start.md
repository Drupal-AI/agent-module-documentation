<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - STDIO Server (mcp_tools_stdio) — agent index

Transport submodule of **MCP Tools**. Serves the MCP protocol over **STDIO** via one Drush command,
`mcp-tools:serve` — the recommended transport for local AI clients. Depends on `mcp_tools`. Requires
`mcp/sdk` (enforced by `hook_requirements`). No routes, no permissions, no config of its own. Core
`^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version dir 1.0.x (installed 1.0.0-beta8).

- **The `mcp-tools:serve` command, its options, and the STDIO auth boundary** →
  [drush/serve.md](drush/serve.md)

## What it provides (from source)

- `src/Commands/McpToolsStdioCommands.php` — `serve()` (`#[CLI\Command('mcp-tools:serve')]`, aliases
  `mcp-tools-server`, `mcp-tools:server`). Builds `Mcp\Server` from the parent
  `McpToolsServerFactory` and runs `$server->run(new StdioTransport())`.
- `drush.services.yml` — registers the command service, injecting `plugin.manager.tool`,
  `mcp_tools.resource_registry`, `mcp_tools.prompt_registry`, `mcp_tools.server_config_repository`,
  `mcp_tools.tool_error_handler`, `mcp_tools.access_manager`, `entity_type.manager`,
  `account_switcher`, `event_dispatcher`, logger channel `mcp_tools_stdio`.
- `mcp_tools_stdio.services.yml` — the `logger.channel.mcp_tools_stdio` channel.
- `mcp_tools_stdio.install` — `hook_requirements()` errors if `Mcp\Server` (mcp/sdk) is missing.

## Options (from the command)

`--server` (profile id) · `--scope` (comma list read,write,admin) · `--uid` (account to run as) ·
`--all-tools` · `--gateway`. Order of effect: optional `AccountSwitcher::switchTo($uid)`, resolve
and validate the server profile (`allowsTransport(…, 'stdio')`, `checkAccess()`), apply scope
override or profile scopes via `AccessManager::setScopes()`, then build and run the server.
