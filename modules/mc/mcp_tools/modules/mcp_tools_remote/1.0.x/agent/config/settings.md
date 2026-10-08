<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools Remote — settings, routes, permissions

## Config object `mcp_tools_remote.settings`

Schema `config/schema/mcp_tools_remote.schema.yml`, defaults `config/install/mcp_tools_remote.settings.yml`.

| Key | Default | Meaning |
| --- | --- | --- |
| `enabled` | `false` | Master switch for the `/_mcp_tools` endpoint. Off → route returns 404. |
| `uid` | `0` | Drupal user id tools run as. `0` = not configured (endpoint 500s). |
| `allow_uid1` | `false` | Must be TRUE to permit `uid: 1`; otherwise uid-1 execution is refused. |
| `allowed_ips` | `[]` | Client IP/CIDR allowlist. Empty = any IP (not recommended on public nets). |
| `allowed_origins` | `[]` | Origin/Referer/Host allowlist (wildcard subdomains ok). DNS-rebinding defense. |
| `server_name` | `Drupal MCP Tools` | Advertised server name (overridden by a profile). |
| `server_version` | `1.0.0` | Advertised version. |
| `server_id` | `''` | Optional `mcp_tools_servers.settings` profile id to serve. |
| `pagination_limit` | `50` | MCP list pagination. |
| `include_all_tools` | `false` | Expose all Tool API tools vs only `mcp_tools` providers. |
| `gateway_mode` | `false` | Expose only discover/info/execute gateway tools. |

Managed at `/admin/config/services/mcp-tools/remote` (`RemoteSettingsForm`). API keys are NOT in
this config — they are hashed in `State` (see the endpoint doc).

## Routes

- `mcp_tools_remote.handle` — `/_mcp_tools` (GET, POST), `_mcp_remote_access: 'TRUE'`, `no_cache`.
- `mcp_tools_remote.settings` — `/admin/config/services/mcp-tools/remote`, `_permission:
  'mcp_tools administer'` (permission defined by the parent module).

## Permissions

None defined by this submodule; the settings form reuses the parent's `mcp_tools administer`.

## `hook_requirements` (`mcp_tools_remote.install`)

- Errors if `mcp/sdk` (`Mcp\Server`) is missing (install + runtime).
- At runtime, when `enabled`: errors if `uid` is 0 (not configured) or the configured user does not
  exist; otherwise reports the execution user as OK. Links to the remote settings form.
