<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Model Context Protocol (MCP) turns a Drupal site into an MCP server, exposing tools and resources to LLM clients (Claude Desktop, Claude Code, Cursor, etc.) over a single JSON-RPC 2.0 HTTP endpoint, and defines an `mcp` plugin type so other modules — and several built-in plugins — can contribute those tools and resources.

---

The module registers one protocol route, `POST /mcp/post` (`mcp.post`), plus admin UI routes under `/admin/config/mcp`. The endpoint is built on the `drupal/jsonrpc` contrib module: `McpController` extends jsonrpc's `HttpController` and dispatches to `mcp_jsonrpc_method` plugins in `src/Plugin/McpJsonRpc/` (`initialize`, `tools/list`, `tools/call`, `resources/list`, `resources/templates/list`, `resources/read`, `notifications/initialized`); protocol version is `2025-03-26`. Access is gated by the `use mcp server` permission and by request authentication — the route declares `_auth: [mcp_auth, cookie, oauth2]`, where `mcp_auth` is a custom provider (`McpAuthProvider`) supporting HTTP Basic (username:password) and a shared bearer token (a `key` module Key mapped to one Drupal user); OAuth2 and session cookies also work. Enabling auth is a setting (`enable_auth`, default off — when off only cookie/oauth2 apply, so anonymous callers still need the `use mcp server` permission which is not granted by default). Tools and resources come from `mcp` plugins (attribute `#[Mcp]`, base `McpPluginBase`, manager `plugin.manager.mcp`); each request re-checks `hasAccess()` (plugin `use mcp server` + per-plugin allowed roles) and `hasToolAccess()` (per-tool enable + per-tool roles), and the delegated tool/resource code runs entity/JSON:API access checks. Core ships seven plugins: `general` (site info + update status), `content` (nodes as resources + a `search-content` tool, opt-in per content type), `jsonapi` (read via JSON:API, additionally requires `access content`), `aif` (Drupal AI function calls), `aia` (Drupal AI agents), `tools` (Tool API), and `drush` (run allow-listed Drush commands — disabled by default, dev only). Configure everything at `/admin/config/mcp` (auth), `/admin/config/mcp/plugins` (enable plugins, set roles, per-tool config), and `/admin/config/mcp/connection` (copy-paste client config). Submodule `mcp_studio` lets admins define no-code tools (static or Twig-rendered output). `drush generate mcp:plugin` scaffolds a custom plugin.

---

- Expose a Drupal site as an MCP server so LLM clients (Claude Desktop, Claude Code, Cursor, Zed) can call its tools.
- Authenticate MCP clients with HTTP Basic auth (Drupal username + password) over the `/mcp/post` endpoint.
- Authenticate MCP clients with a shared bearer token (a Key entity) mapped to a specific Drupal user.
- Let clients authenticate via OAuth2 or an existing session cookie without extra MCP config.
- Restrict who can use the server with the `use mcp server` permission, and per-plugin / per-tool allowed roles.
- Return site name, slogan and core version to a client via the `general` plugin's `info` tool.
- Report modules needing (security) updates to an LLM via the `general` plugin's `status` tool.
- Serve selected content types' nodes to an LLM as MCP resources for retrieval-augmented workflows (`content` plugin).
- Let an assistant query published nodes with field filters/operators via the `content` plugin's `search-content` tool.
- Read entities through Drupal JSON:API (filters, includes, sparse fieldsets, pagination) via the `jsonapi` plugin.
- Give an LLM JSON Schema for resource types via the `jsonapi` plugin's `jsonapi_schema` tool (needs jsonapi_schema).
- Surface Drupal AI module function calls as MCP tools (`aif` plugin, needs drupal/ai).
- Drive Drupal AI agents from an MCP client with a natural-language prompt (`aia` plugin, needs drupal/ai_agents).
- Expose Tool API tools (with input/output schemas and entity artifact tokens) as MCP tools (`tools` plugin, needs drupal/tool).
- Run a curated allow-list of Drush commands from an MCP client for development/ops (`drush` plugin, off by default).
- Build no-code MCP tools whose output is a static string or a Twig template rendered from the call arguments (`mcp_studio`).
- Customize the description shown to LLMs per tool, or disable individual tools, from the plugins admin UI.
- Enable or disable individual MCP plugins and scope each to specific roles at `/admin/config/mcp/plugins`.
- Copy ready-made Claude Desktop / Claude Code / Cursor client configs from `/admin/config/mcp/connection`.
- Advertise available tools and resources to a client through `tools/list`, `resources/list`, `resources/templates/list`.
- Implement resource templates (URI patterns like `node/{type}/{id}`) for parameterized reads.
- Build a custom `mcp` plugin (via `drush generate mcp:plugin`) exposing a bespoke tool or an external data source as a resource.
- Integrate Drupal into a multi-tool MCP agent alongside other MCP servers behind one JSON-RPC endpoint.
- Flood-protect the endpoint against brute-forced Basic/token credentials (per-IP and per-user limits).
