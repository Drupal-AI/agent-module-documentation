<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MCP Client lets Drupal connect to external Model Context Protocol (MCP) servers and expose their tools to the AI module as function-call plugins.
---
The problem it solves: AI agents in Drupal need access to external tools and data sources. MCP is a standard protocol for that; this module is the client side — it connects to one or more MCP servers, discovers the tools they offer, and surfaces the enabled ones as `tool` plugins that the AI/AI Agents modules can call.

How it works: each server is a `mcp_server` config entity (admin UI under Structure) with a transport type of `http` or `stdio`. `McpClientFactory::createFromEntity()` builds an `MCPClient` (a wrapper over the official `mcp/sdk`): for HTTP it uses the configured endpoint URL plus headers; for STDIO it launches a local command with configured env vars and cwd. Credentials are stored securely via the Key module — HTTP `Authorization` (and other headers) and STDIO env vars can reference a Key entity, whose value is resolved at call time rather than stored in config. Discovered tools are exposed through a `tool` plugin deriver (`McpToolDeriver`/`McpToolBase`); the `listTools()` cursor loop is bounded (max 100 pages) to resist a hostile/looping server.

Security & operational notes: the server endpoint, STDIO command and credentials are all administrator-configured — reaching the connection requires the `administer mcp_server` permission, so there is no request-supplied server URL (no unauthenticated SSRF). The STDIO transport does run a local process (arbitrary command execution by design), so grant `administer mcp_server` only to trusted admins. Prefer Key references over literal secrets for headers/env.

Setup: enable the module (needs AI, AI Agents, Key, Tool; PHP 8.2+), create Key entities for any tokens, add an MCP server at `/admin/structure/mcp-server` (choose HTTP + endpoint or STDIO + command), then enable the specific tools to expose to your AI agents.
---
- Connect Drupal to a remote MCP server over HTTP.
- Run a local MCP server as a STDIO subprocess.
- Register multiple MCP servers and use them simultaneously.
- Discover the tools a server offers automatically.
- Enable or disable individual tools per server.
- Expose MCP tools to AI Agents as function-call plugins.
- Store an API token in a Key entity and reference it from a header.
- Add a `Bearer`/`Token` prefix to a resolved Authorization header.
- Pass secret env vars to a STDIO server via Key references.
- Set a per-server request/connection timeout.
- Send custom HTTP headers to an MCP server.
- Set the working directory for a STDIO server process.
- List a server's tools with bounded pagination (max 100 pages).
- Execute a specific tool with arguments and read its result.
- Restrict server configuration to admins via `administer mcp_server`.
- Buffer STDIO stderr to surface connection-failure diagnostics.
- Add, edit and delete server definitions from the admin UI.
- Integrate discovered tools into AI function-calling workflows.
