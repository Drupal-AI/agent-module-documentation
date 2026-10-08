<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools Remote Server (mcp_tools_remote) — agent index

Transport submodule of **MCP Tools**. Serves the MCP protocol over **HTTP** (MCP Streamable HTTP)
at `/_mcp_tools` with API-key authentication. **Disabled by default**; fails closed. Depends on
`mcp_tools`. Requires `mcp/sdk` (enforced by `hook_requirements`, which also warns at runtime when
enabled without a valid execution user). Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later.
Version dir 1.0.x (installed 1.0.0-beta8).

- **The HTTP endpoint pipeline, auth, scopes, execution user, and key management** →
  [http/endpoint.md](http/endpoint.md)
- **Settings (`mcp_tools_remote.settings`), routes and permissions** →
  [config/settings.md](config/settings.md)

## What it provides (from source)

- **Route** `mcp_tools_remote.handle` → `/_mcp_tools` (GET, POST), gated by
  `_mcp_remote_access: 'TRUE'` (custom access check `McpRemoteAccessCheck`), `no_cache`. Controller
  `src/Controller/McpToolsRemoteController.php` (`handle()`).
- **Route** `mcp_tools_remote.settings` → `/admin/config/services/mcp-tools/remote`
  (`RemoteSettingsForm`, permission `mcp_tools administer`).
- **Access check** `src/Access/McpRemoteAccessCheck.php` — a presence gate only: 403 if the module
  is disabled or no API key/Bearer header is present; the controller does full validation.
- **API keys** `src/Service/ApiKeyManager.php` — wraps `code-wheel/mcp-http-security`
  `ApiKeyManager`; keys stored **hashed** in `State`, peppered with `@private_key`; carry scopes +
  optional TTL. `validate()`, `createKey()`, `listKeys()`, `revokeKey()`.
- **Drush** `src/Commands/McpToolsRemoteCommands.php` — `mcp-tools:remote-key-create`,
  `mcp-tools:remote-key-list`, `mcp-tools:remote-key-revoke`, `mcp-tools:remote-setup` (creates a
  dedicated executor user + role and sets `uid`).
- **Config** object `mcp_tools_remote.settings` (schema `config/schema/`, defaults
  `config/install/`): `enabled`, `uid`, `allow_uid1`, `allowed_ips`, `allowed_origins`,
  `server_name/version/id`, `pagination_limit`, `include_all_tools`, `gateway_mode`.
- **Support classes**: `Clock/DrupalClock`, `Storage/DrupalStateStorage` (State-backed key store).
