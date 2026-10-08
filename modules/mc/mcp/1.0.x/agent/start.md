<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Model Context Protocol (MCP) — agent index

Turns Drupal into an MCP server: a JSON-RPC 2.0 API (optionally SSE-streamed) exposing tools and
resources contributed by `mcp` plugins. Core ships the `general` plugin; submodules add content and
AI tools. Settings at `/admin/config/mcp`. Endpoints gated by `access content`.

- **Endpoints, JSON-RPC methods, SSE session flow** → [api/endpoints.md](api/endpoints.md)
- **The `mcp` plugin type: implement tools & resources** → [plugins/mcp-plugins.md](plugins/mcp-plugins.md)
- **Settings form (`mcp.settings`: enable_sse + per-plugin config)** → [configure/settings.md](configure/settings.md)

Submodules (own docs):
- `mcp_content` (content as resources + search tool) →
  [../../modules/mcp_content/1.0.x/agent/start.md](../../modules/mcp_content/1.0.x/agent/start.md)
- `mcp_ai` (AI function-calls as tools) →
  [../../modules/mcp_ai/1.0.x/agent/start.md](../../modules/mcp_ai/1.0.x/agent/start.md)

Key facts:
- Routes: `mcp.get` (`GET /mcp/get`, SSE), `mcp.post` (`POST /mcp/post`, JSON-RPC) — both
  `_permission: 'access content'`; `mcp.settings` (`/admin/config/mcp`, `administer site configuration`).
- Protocol version `2024-11-05`. Methods: `initialize`, `tools/list`, `tools/call`,
  `resources/list`, `resources/templates/list`, `resources/read`.
- Plugin type `mcp`: `#[Mcp]` attribute + `McpPluginBase`, discovered from `Plugin/Mcp/`.
  Service `mcp.service` (`McpService`) aggregates enabled plugins; manager `plugin.manager.mcp`.
- Tool names are namespaced `pluginId_toolName`; resource URIs `pluginId://…`.
