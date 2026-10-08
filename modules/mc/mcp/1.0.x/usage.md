<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Model Context Protocol (MCP) turns a Drupal site into an MCP server, exposing tools and resources to LLM applications over a JSON-RPC 2.0 API (optionally streamed via HTTP Server-Sent Events), and defines an `mcp` plugin type so other modules can contribute those tools and resources.

---

The module registers three routes: `GET /mcp/get` (SSE connect), `POST /mcp/post` (JSON-RPC message endpoint), both requiring only the `access content` permission, and `/admin/config/mcp` (settings, requiring `administer site configuration`). `McpController` speaks MCP protocol version `2024-11-05` and handles the JSON-RPC methods `initialize`, `tools/list`, `tools/call`, `resources/list`, `resources/templates/list`, and `resources/read`, delegating to `McpService`, which aggregates every enabled `mcp` plugin. In SSE mode (`enable_sse`, default on) a client opens the GET stream to receive a `sessionId`, then POSTs messages tagged with that session; responses are relayed back over the stream via Drupal `State` entries with a 60-second heartbeat loop. `mcp` plugins are discovered from `Plugin/Mcp/` classes carrying the `#[Mcp]` attribute (id/name/description) and extending `McpPluginBase`; each can expose tools (`getTools`/`executeTool`), resources (`getResources`/`readResource`) and resource templates, plus a per-plugin settings subform. The core module ships one plugin, `general` (a `general_info` tool returning site name/slogan/Drupal version). The settings form lists all discovered plugins with an enable checkbox and their custom config. Submodules add more plugins: `mcp_content` (Drupal content as resources + a content-search tool) and `mcp_ai` (Drupal AI function-calls as MCP tools).

---

- Expose a Drupal site as an MCP server so LLM clients (Claude Desktop, Zed, etc.) can call its tools.
- Serve site content to an LLM as MCP resources for retrieval-augmented workflows.
- Let an AI assistant query published nodes via the `content_search-content` tool (with mcp_content).
- Surface Drupal AI module function-calls as MCP tools an LLM can invoke (with mcp_ai).
- Return basic site info (name, slogan, core version) to a client via the built-in `general` plugin.
- Build a custom `mcp` plugin that exposes a bespoke tool (any callable) to LLM clients.
- Build a custom `mcp` plugin that exposes an external data source as a readable MCP resource.
- Connect Drupal to a third-party stdio MCP server binary that proxies to `/mcp/post`.
- Stream real-time MCP responses to a client over HTTP Server-Sent Events.
- Toggle SSE off to use a simple request/response JSON-RPC endpoint instead.
- Enable or disable individual MCP plugins from the `/admin/config/mcp` settings page.
- Restrict which content types are exposed to MCP clients (via the content plugin's config).
- Prototype AI-driven editorial workflows that read and search Drupal content.
- Provide contextual site data to an IDE-integrated LLM for code/content assistance.
- Advertise available tools and resources to a client through `tools/list` / `resources/list`.
- Implement resource templates (URI patterns like `node/{type}/{id}`) for parameterized reads.
- Let another module contribute MCP capabilities without changing this module (plugin architecture).
- Integrate Drupal into a multi-tool MCP agent alongside other MCP servers.
- Expose read-only reference data (glossaries, catalogs) to an assistant as MCP resources.
- Give an LLM a standardized `initialize` handshake advertising server capabilities.
- Centralize AI tool exposure behind one protocol endpoint instead of bespoke REST APIs.
