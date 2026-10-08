<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP endpoints & JSON-RPC API

`McpController` (protocol version `2024-11-05`). Three routes:

| Route | Path | Method | Permission |
|---|---|---|---|
| `mcp.get` | `/mcp/get` | GET | `access content` |
| `mcp.post` | `/mcp/post` | POST | `access content` |
| `mcp.settings` | `/admin/config/mcp` | — | `administer site configuration` |

## JSON-RPC methods (`POST /mcp/post`, body = a JSON-RPC 2.0 message)
`handleMessage()` requires `id` and `method`; dispatches on `method`:

- `initialize` → returns `protocolVersion`, `capabilities` (`resources`, `tools`), and `serverInfo`
  (`Drupal MCP Server` / `0.0.1`).
- `tools/list` → `{ tools: McpService::getTools() }` — every enabled plugin's tools, each renamed
  `pluginId_toolName`.
- `tools/call` → `{ content: McpService::executeTool(params.name, params.arguments) }`. The tool id is
  split on the **first** `_` into `pluginId` + `toolName`; the plugin must pass `checkRequirements()` and
  `isEnabled()`.
- `resources/list` → `{ resources: getResources() }`; each URI prefixed `pluginId://`.
- `resources/templates/list` → `{ resourceTemplates: getResourceTemplates() }`.
- `resources/read` → `{ contents: readResource(params.uri) }`. URI is split on `://` into `pluginId` +
  `resourceId`.
- Unknown method or missing id/method → JSON-RPC error `-32603` (exceptions are caught and returned as
  the error message).

## SSE session flow (`enable_sse`, default TRUE)
1. Client opens `GET /mcp/get` (`StreamedResponse`, `Content-Type: text/event-stream`). The controller
   generates `client_id = uniqid('mcp-client-', TRUE)`, stores `state: mcp.client_id.<id> = TRUE`, and
   emits an `endpoint` SSE event containing `/mcp/post?sessionId=<client_id>`.
2. The stream then loops for up to `MCP_HEARTBEAT_TIMEOUT` (60s), polling `state: mcp.message.<id>`
   every 1s and flushing any queued response as a `message` event; it breaks if the client_id state is
   gone or the connection drops.
3. Client `POST`s JSON-RPC messages to `/mcp/post?sessionId=<client_id>`. With SSE on, `post()`
   validates the `sessionId` against stored state (400 `Invalid session` otherwise), computes the
   response, stores it in `state: mcp.message.<id>` for the stream to deliver, and returns
   `{status: ok}`.
4. If `enable_sse` is FALSE, `GET /mcp/get` returns `{error: 'SSE is disabled'}` (400) and `POST` skips
   the session check and returns the JSON-RPC response **directly** in the HTTP body.

## Services
- `mcp.service` (`McpService`) — aggregates enabled plugins: `getTools`, `executeTool`, `getResources`,
  `getResourceTemplates`, `readResource`.
- `plugin.manager.mcp` (`McpPluginManager`) — discovery + instantiation (merges per-plugin config from
  `mcp.settings`).
