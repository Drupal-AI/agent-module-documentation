<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CTX (ctx) — agent index

MCP tools that expose a Drupal site's structure and state to AI coding assistants. Local-development only (the README warns against production / public sites). Version dir `1.0.x` (packaged `1.0.0-beta7`). Core `^11.3`, **PHP `^8.4`**.

Despite the packaged description ("Provides Drush commands…"), CTX ships **no Drush commands** — it registers one MCP server and ~55 MCP tool plugins.

## Dependencies
- Drupal modules: `file`, `mcp_core` (MCP Core).
- Composer: `drupal/mcp_core ^1.0.0-beta12`, `mcp/sdk ^0.8.0`; dev: `drush/drush ^13.7`.

## What it provides
- **MCP server**: `Drupal\ctx\Plugin\McpServer\CtxServer` (id `ctx`) — a plugin of mcp_core's `McpServer` type. Carries usage `instructions` (prefer dedicated tools over php_eval; run `ctx_cache_clear` after writes; check `ctx_watchdog_list` after errors).
- **~55 MCP tools**: plugins of mcp_core's `McpTool` type under `src/Plugin/McpTool/**`, each `extends McpToolBase`, `id` `ctx_*`, `server: CtxServer::ID`. Grouped by directory: `Extension/`, `Config/`, `ConfigEntity/`, `ConfigEntityType/`, `ContentEntity/`, `ContentEntityType/`, `Database/`, `Php/`, `Plugin/`, `Service/`, `Router/`, `State/`, `Queue/`, `Watchdog/`, `Cron/`, `Cache/`, `User/`, `Site/`, `File/`.
- **Services** (`ctx.services.yml`, autowired): `PluginTypeRegistry` (auto-discovers `plugin.manager.*` services), `PluginDefinitionNormalizer`.
- **Hook**: `hook_ctx_plugin_type_info_alter(array &$plugin_types)` (`ctx.api.php`) — add/rename/remove plugin-type registry entries.

## No routes / permissions / config of its own
CTX defines no `*.routing.yml`, `*.permissions.yml`, `*.install`, `*.module`, or `config/`. HTTP access is served entirely by mcp_core's `mcp_core.server` route `/mcp/{server}`, gated by the `_mcp_core_bearer_token` requirement. Tools run with full site privileges once that gate is passed — hence the local-only guidance.

## Solution docs
- Server, tool architecture, and setup: [agent/mcp/server.md](mcp/server.md)
- Full tool catalog (all ~55 `ctx_*` tools by group): [agent/mcp/tools.md](mcp/tools.md)
- Plugin-type registry + `hook_ctx_plugin_type_info_alter`: [agent/api/plugin-type-registry.md](api/plugin-type-registry.md)
