<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Model Context Protocol (MCP) — agent index

Turns Drupal into an MCP server: a single JSON-RPC 2.0 endpoint (`POST /mcp/post`, built on the
`drupal/jsonrpc` module) exposing tools and resources contributed by `mcp` plugins. Core ships seven
plugins (general, content, jsonapi, aif, aia, tools, drush); submodule `mcp_studio` adds no-code tools.
Access = `use mcp server` permission + request auth (`mcp_auth` Basic/token, cookie, oauth2). Admin at
`/admin/config/mcp`.

- **Endpoint, JSON-RPC methods, auth, access model** → [api/endpoints.md](api/endpoints.md)
- **The `mcp` plugin type + the built-in plugins** → [plugins/mcp-plugins.md](plugins/mcp-plugins.md)
- **Settings: auth, per-plugin & per-tool config, roles** → [configure/settings.md](configure/settings.md)

Key facts:
- Route `mcp.post` (`POST /mcp/post`) — `_permission: 'use mcp server'`, `_auth: [mcp_auth, cookie, oauth2]`.
- Admin routes (all `_permission: 'administer mcp configuration'`): `mcp.settings` (`/admin/config/mcp`),
  `mcp.plugins` (`/admin/config/mcp/plugins`), `mcp.plugin.settings`
  (`/admin/config/mcp/plugins/{plugin}/settings`), `mcp.connection` (`/admin/config/mcp/connection`).
- Permissions: `use mcp server` (call the server), `administer mcp configuration` (restricted).
- Protocol version `2025-03-26` (advertised by `initialize`; serverInfo = `Drupal MCP Server` / `0.0.1`).
- Plugin type `mcp`: `#[Mcp]` attribute + `McpPluginBase`, discovered from `Plugin/Mcp/`, manager
  `plugin.manager.mcp`. JSON-RPC methods are `mcp_jsonrpc_method` plugins in `Plugin/McpJsonRpc/`.
- Tool names are namespaced `pluginId_toolName` (see `generateToolId`); resource URIs `pluginId://…`.
- Dependencies: `serialization`, `jsonrpc:jsonrpc` (^2.1), `key:key` (^1.19). PHP >= 8.1.
- No SSE / no `/mcp/get` anymore (both removed since 1.0.x); no submodules `mcp_ai`/`mcp_content` (their
  plugins were merged into the main module — see the `mcp_update_103xx`/`104xx`/`105xx` update hooks).
- Scaffold a plugin: `drush generate mcp:plugin` (`src/Drush/Generators/McpPluginGenerator`).
