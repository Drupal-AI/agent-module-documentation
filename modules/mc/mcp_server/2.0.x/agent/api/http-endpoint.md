<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — transports, endpoint, auth, sessions

The server object is built per request by `McpServerFactory::create()` (service
`mcp_server.server.factory`) and exposed as the non-shared service `mcp_server.server`
(`Mcp\Server`). The factory sets server info/pagination/logger/event-dispatcher/session store, adds a
`CustomCallToolHandler`, then registers tools, prompts and resources on the SDK `Server\Builder`.

## HTTP transport (`/_mcp`)

- Route `mcp_server.handle` (`mcp_server.routing.yml`): path `/_mcp`, `methods: [GET, POST]`,
  `_controller: McpServerController::handle`, `requirements._permission: 'access mcp server'`,
  `options._auth: ['cookie']`, `no_cache: TRUE`.
- `McpServerController::handle(Request $request, ServerRequestInterface $psrRequest)`
  (`src/Controller/McpServerController.php`):
  1. logs the request and whether the current user is anonymous or a named account;
  2. wraps the PSR-7 request in `Mcp\Server\Transport\StreamableHttpTransport`;
  3. calls `$this->mcpServer->run($transport)` → PSR-7 response;
  4. non-seekable (SSE) bodies are streamed via `httpFoundationFactory->createResponse($psr, TRUE)`;
     seekable bodies are returned directly.
- Auth: cookie by default. When `mcp_server_oauth` is enabled, `RouteSubscriber::alterRoutes()`
  appends `oauth2` to `_auth`, so a Simple OAuth Bearer token authenticates the request too. The
  `access mcp server` permission still applies to whichever account is resolved.
- MCP session id travels in the `mcp-session-id` header; `McpCorsConfigPass` adds `POST` and the
  `content-type` / `mcp-protocol-version` / `mcp-session-id` headers to the site `cors.config` so
  browser MCP clients (e.g. MCP Inspector) work.

### JSON-RPC error mapping

`McpAuthorizationDeniedException` (thrown by the authorize event, see
[../events/authorize.md](../events/authorize.md)) is caught in `handle()` and turned into a JSON-RPC
error by `buildAuthorizationErrorResponse()`:

- HTTP 401 → error code `-32001`, header `WWW-Authenticate: Bearer realm="mcp_server"`.
- HTTP 403 → error code `-32003`, header `WWW-Authenticate: Bearer error="insufficient_scope"`.

(With `mcp_server_oauth`, `AuthenticationErrorSubscriber` additionally rewrites any main-request
`JsonResponse` whose JSON-RPC body carries code `-32001` to HTTP 401 + the `WWW-Authenticate` header.)

## STDIO transport (drush)

- `drush mcp:server` (alias `mcps`) — `McpServerCommands::server()` (`src/Commands/McpServerCommands.php`)
  runs the same `mcp_server.server` over `Mcp\Server\Transport\StdioTransport`. Intended for local
  clients such as Claude Desktop:

  ```json
  { "mcpServers": { "drupal": { "command": "vendor/bin/drush", "args": ["mcp:server"] } } }
  ```

  Authorization denials are printed to STDOUT as JSON-RPC errors (`-32001` / `-32003`).

## Sessions

Two tables created by `mcp_server_schema()` (`mcp_server.install`):

- `mcp_session_metadata` — keyed by `session_id` (UUID v4, 36 chars); columns `roots`
  (JSON filesystem roots), `created_at`, `expires_at`, `last_activity`. Managed by
  `DbSessionManager` (`createSession`, `validateSession`, `updateActivity`, `destroySession`, `gc`).
- `mcp_session_queue` — keyed by `session_id`; `data` (big blob: serialized SDK protocol state),
  `last_activity`, `expires_at`. Implements the SDK `SessionStoreInterface` via
  `DatabaseSessionStore` (`exists`, `read`, `write` (merge/upsert), `destroy`, `gc`).
- `SessionContext` (readonly) carries `sessionId`, `expiry`, `roots` with `isExpired()` /
  `isRootAllowed()`. `mcp_server_update_10002()` drops the obsolete `mcp_pending_request` table.
