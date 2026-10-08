<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Client (mcp_client) — agent index

**Connects Drupal to external MCP servers (HTTP/STDIO) and exposes their tools to the AI module as function-call plugins.**

- **Version:** 1.0.x (1.0.0-alpha2)
- **Core:** `^10.3 || ^11`  •  **PHP 8.2+**  •  **Depends:** ai, ai_agents, key, tool
- **Config entity:** `mcp_server` (admin UI `/admin/structure/mcp-server`, all routes `administer mcp_server`)
- **Services:** `mcp_client.client_factory` (`McpClientFactory`, injects `key.repository`), logger channel `mcp_client`.
- **Plugins:** `tool` plugins derived per enabled MCP tool (`McpToolDeriver`, `McpToolBase`).

**Security:** Admin-only surface. Server endpoint URL, STDIO command, headers and env vars are all set through the `administer mcp_server`-gated config entity — there is no request-supplied target, so no unauthenticated SSRF. Credentials use the Key module (`KeyRepository::getKey()->getKeyValue()` resolved at call time), not plaintext config. Note by design: the STDIO transport executes a local process, so `administer mcp_server` is effectively command-execution — grant only to trusted admins. `listTools()` pagination is capped (100 pages) against a looping server.

See [configure/mcp_client.md](configure/mcp_client.md).
