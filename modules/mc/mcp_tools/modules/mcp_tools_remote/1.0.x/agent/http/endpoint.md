<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools Remote — the HTTP endpoint and its authorization pipeline

## Enable and provision

`drush en mcp_tools_remote -y` (needs `mcp_tools` + `mcp/sdk`). The endpoint is **off** until
`mcp_tools_remote.settings:enabled` is TRUE **and** an execution user is set. Fast path:

```
drush mcp-tools:remote-setup                       # creates executor user + role, sets uid
drush mcp-tools:remote-key-create --label=Claude --scopes=read
# then enable the endpoint in the UI or config
```

Client: `claude mcp add drupal http://host/_mcp_tools --transport http -H "Authorization: Bearer KEY"`.

## Route gate

`mcp_tools_remote.handle` (`/_mcp_tools`, GET/POST) uses `_mcp_remote_access: 'TRUE'` →
`McpRemoteAccessCheck::access()`, a **presence check**: forbidden if the module config is disabled,
forbidden if neither `Authorization: Bearer …` nor `X-MCP-Api-Key` is present; otherwise allowed
with `max-age=0`. All real validation is in the controller.

## Controller pipeline (`McpToolsRemoteController::handle()`), in order

1. **`enabled` re-check** → `Response(404)` if off (a disabled endpoint is indistinguishable from a
   nonexistent one).
2. **Security checks** (`performSecurityChecks`):
   - **IP allowlist** — if `allowed_ips` is non-empty, a client outside it → `404` (`IpValidator`).
   - **Origin** (`validateOrigin`) — with an `allowed_origins` list, a non-matching Origin → `404`;
     with no list, an Origin header must equal the request Host (same-origin default) → `404`
     otherwise. DNS-rebinding defense-in-depth (`OriginValidator`).
   - **Accept header** (`validateAcceptHeader`) — POST must accept both `application/json` and
     `text/event-stream`; GET must accept `text/event-stream`; else `406`.
3. **API key** (`extractApiKey` → `ApiKeyManager::validate`) — missing/invalid → `401` with
   `WWW-Authenticate: Bearer`. Keys are hashed+peppered in State (not config), validated by the
   `code-wheel/mcp-http-security` library (no hand-rolled `==`).
4. **Server profile** (if `server_id` set) — `getServer()`, `checkAccess()`, and
   `allowsTransport(…, 'http')`; failures → `403`/`500`.
5. **Rate-limit client id** — set from the key id (`remote_key:<key_id>`).
6. **Scopes** (`resolveScopes`) — `key['scopes'] ∩ mcp_tools.settings:allowed_scopes`, then
   `∩ profile scopes`; empty → `403`. Applied via `accessManager->setScopes()`.
7. **Execution user** (`resolveExecutionAccount`) — `uid` from config; `uid === 0` → `500` (not
   configured); `uid === 1` with `allow_uid1` false → `500` (refused); user must load. 
8. **Account switch** → `accountSwitcher->switchTo($executionUser)`, run
   `executeRequest()` (builds the server via `McpToolsServerFactory`, a `FileSessionStore` in the
   system temp dir, `StreamableHttpTransport`), `switchBack()` in a `finally`. Response gets
   `Cache-Control: no-store`.

## Authorization model

Every tool the remote client calls is checked by `McpToolsToolBase::checkAccess()` **as the
configured execution user** with the **API key's resolved scopes**. So HTTP access requires: a
valid hashed key, the key's scope for the operation, the execution account holding
`mcp_tools use <category>`, and the parent's read-only/config-only policy. It is never anonymous and
never runs as an ambient account — it fails closed if the execution user is unset and refuses uid 1
by default. Operational safety is therefore a configuration responsibility: populate the IP/Origin
allowlists, issue least-privilege scoped (optionally TTL'd) keys, and point `uid` at a dedicated
executor account rather than uid 1.

## Key management (Drush)

- `mcp-tools:remote-key-create --label --scopes=read,write --ttl=SECONDS` — prints the key **once**.
- `mcp-tools:remote-key-list [--format=table|json]` — redacted (no hashes).
- `mcp-tools:remote-key-revoke <key_id>`.
- `mcp-tools:remote-setup --username --role --categories --allow-uid1` — creates/loads a user and a
  role granted `mcp_tools use <category>` for the listed categories (+ `discovery`), sets
  `uid`/`allow_uid1`, and prints next steps (allowlist, key, enable).
