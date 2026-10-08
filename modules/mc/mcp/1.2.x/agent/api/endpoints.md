<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP endpoint, JSON-RPC API & access model

Built on `drupal/jsonrpc`. `McpController` extends `\Drupal\jsonrpc\Controller\HttpController` and swaps
in the `mcp.jsonrpc.handler` (a jsonrpc `Handler` fed by the `plugin.manager.mcp_jsonrpc_method` manager).
There is **one** protocol route (no SSE / no `/mcp/get` — both were removed after 1.0.x).

| Route | Path | Method | Permission | Auth |
|---|---|---|---|---|
| `mcp.post` | `/mcp/post` | POST | `use mcp server` | `mcp_auth`, `cookie`, `oauth2` |
| `mcp.settings` | `/admin/config/mcp` | — | `administer mcp configuration` | — |
| `mcp.plugins` | `/admin/config/mcp/plugins` | — | `administer mcp configuration` | — |
| `mcp.plugin.settings` | `/admin/config/mcp/plugins/{plugin}/settings` | — | `administer mcp configuration` | — |
| `mcp.connection` | `/admin/config/mcp/connection` | — | `administer mcp configuration` | — |

`{plugin}` is upcast to an `McpInterface` instance by the `mcp_plugin` param converter (`McpPluginConverter`).

## Request body
A JSON-RPC 2.0 message (`{"jsonrpc":"2.0","id":…,"method":…,"params":{…}}`). Batches supported by the
jsonrpc handler. Errors come back as JSON-RPC error objects; the controller wraps uncaught exceptions via
`JsonRpcException::fromPrevious()`. On an `AccessDeniedHttpException` for a `/mcp*` path,
`McpAccessDeniedSubscriber` rewrites the response to a JSON-RPC error `-32001` with HTTP 401.

## JSON-RPC methods (`mcp_jsonrpc_method` plugins, `src/Plugin/McpJsonRpc/`)
- `initialize` → `protocolVersion` = **`2025-03-26`**, `capabilities` (`resources`, `tools`), `serverInfo`
  (`Drupal MCP Server` / `0.0.1`). Requires `capabilities`, `clientInfo`, `protocolVersion` params.
- `notifications/initialized` → no-op ack.
- `tools/list` → `{ tools: [...] }`. Iterates `McpPluginManager::getAvailablePlugins()` (enabled + requirements
  met + `hasAccess()` allowed), keeps tools where `isToolEnabled()` && `hasToolAccess()`, renames each to
  `generateToolId(pluginId, toolName)` (sanitized `pluginId_toolname`, hashed/truncated to ≤ 64 chars).
- `tools/call` (`params.name`, `params.arguments`) → splits `name` on the **first** `_` into pluginId+toolPart,
  instantiates the plugin, then enforces, in order: `checkRequirements()` && `isEnabled()`, `hasAccess()`,
  resolve the real tool by sanitized-name / md5 / generated-id match, `isToolEnabled()`, `hasToolAccess()`,
  then `executeTool()`. Result is normalized to `{content:[…], structuredContent?, isError?}`; each content
  item `type` must be `text|image|resource`.
- `resources/list` → `{ resources: [...] }`, each URI prefixed `pluginId://`.
- `resources/templates/list` → `{ resourceTemplates: [...] }`.
- `resources/read` (`params.uri`) → splits URI on `://` into pluginId+resourceId; same requirements/`hasAccess()`
  gate, then `readResource()`. Returns `{ contents: [...] }`.

## Authentication (`_auth: [mcp_auth, cookie, oauth2]`)
- **`cookie`** — a normal Drupal session; the acting user must hold `use mcp server`.
- **`oauth2`** — works if an OAuth2 provider (e.g. simple_oauth) is installed; no MCP-specific config.
- **`mcp_auth`** (`McpAuthProvider`, priority 110) — only *applies* when auth is enabled AND the request path
  starts with `/mcp` AND an `Authorization: Basic …` header is present (`DisallowMcpAuthRequests::isMcpRequest`,
  which also denies page cache for those requests). Decodes the base64 payload:
  - contains `:` → **Basic auth** (`enable_basic_auth`): looks up the user by name (or email), checks not
    blocked/active, verifies the password via `user.auth`. Acts as that user.
  - no `:` → **token auth** (`enable_token_auth`): compares the decoded string to the configured Key's value;
    on match, acts as the configured `token_user`.
  - Flood control mirrors core Basic auth: per-IP (`mcp_auth.failed_login_ip`) and per-user/token limits from
    `user.flood`. Failures throw `McpAuthException` → 401.

## Access model (defence in depth)
1. Route: `_permission: 'use mcp server'` (not granted to anonymous by default) + one of the auth providers.
2. Per plugin: `McpPluginBase::hasAccess()` — allow if `administer mcp configuration`; else require
   `use mcp server`; else if the plugin has allowed `roles`, require role intersection.
3. Per tool: `hasToolAccess()` — plugin access + tool enabled + (tool `roles` intersection, or plugin roles).
4. Delegated code still runs Drupal access checks (e.g. `content` search uses `->accessCheck(TRUE)`; `jsonapi`
   issues an internal sub-request that JSON:API access-controls; `tools` calls `$tool->access()`).
> With `enable_auth` off (default), `mcp_auth` never applies, so callers arrive via cookie/oauth2 and still
> need `use mcp server`. Do **not** grant `use mcp server` to the anonymous role.

## Services
- `mcp.jsonrpc.handler` — jsonrpc `Handler` over `plugin.manager.mcp_jsonrpc_method`.
- `plugin.manager.mcp` (`McpPluginManager`) — discovery/instantiation, merges per-plugin config from
  `mcp.settings:plugins.<id>`; `getAvailablePlugins($getDisabled, $getRestricted)`.
- `mcp.settings` (`McpSettings`) — reads `enable_auth` + `auth_settings`, resolves the token Key value.
