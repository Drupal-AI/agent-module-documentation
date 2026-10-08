<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring an MCP server

Admin UI: `/admin/structure/mcp-server` (permission `administer mcp_server`). Each server is a `mcp_server` config entity.

Common fields: `label`, `description`, `transport_type` (`http`|`stdio`), `timeout` (seconds, default 30), `tools` (enabled tool list).

HTTP transport:
- `endpoint` — the MCP server URL (required).
- `http_headers` — key/value headers. Special handling: `Authorization_key` holds a Key entity id and `Authorization_prefix` (e.g. `Bearer `) is prepended to the resolved key value. Any other header value is looked up in the Key repository; if it matches a Key it is replaced by the secret value, otherwise used literally.

STDIO transport:
- `stdio_command` — the command string (required; run via the SDK's `escapeshellcmd`).
- `stdio_env` — env vars; each entry is `{type: 'key', key_id: '<key>'}` (resolved from the Key module) or `{type:'plain', value:'...'}`. Configured vars are merged over `getenv()` so PATH survives.
- `stdio_cwd` — optional working directory.

Resolution happens in `McpClientFactory` (`resolveHttpHeaders()` / `resolveEnvironmentVariables()`) at connect time. Tools discovered via `MCPClient::listTools()` are exposed as `tool` plugins for AI Agents; enable only the tools you want callable.

Operational caution: STDIO launches a local process — treat `administer mcp_server` as trusted-admin only. Prefer Key references over literal secrets.
