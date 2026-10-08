<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — server settings, resource plugins, prompts, permissions

All admin UI lives in the **`mcp_server_ui`** submodule (the parent module is runtime-only). Enable
`mcp_server_ui` to get the pages under `/admin/config/services/mcp-server`.

## Server settings

- Route: **`mcp_server_ui.settings`** → `/admin/config/services/mcp-server/settings`
  (`_permission: 'administer mcp server'`). Form `McpServerSettingsForm` (form id
  `mcp_server_ui_settings`), editable config **`mcp_server.settings`**.
- Menu link `mcp_server.admin` (parent `system.admin_config_services`, weight 50).

Config object `mcp_server.settings` (schema `config/schema/mcp_server.schema.yml`, install defaults
`config/install/mcp_server.settings.yml`):

| key | type | default | used by |
|---|---|---|---|
| `server_name` | string | `Drupal MCP Server` | `McpServerFactory::create()` → `setServerInfo()` |
| `server_version` | string | `1.0.0` | `setServerInfo()` |
| `pagination_limit` | integer | `50` | `setPaginationLimit()` (clamped to 1–1000; else 50) |
| `session_ttl` | integer | `3600` | session tables' TTL (see note) |
| `pending.poll_interval_ms` | integer | `300` | async sampling/elicitation coordination |
| `pending.sampling_timeout` | integer | `25` | (seconds) |
| `pending.elicitation_timeout` | integer | `600` | (seconds) |

Note: `DbSessionManager`/`DatabaseSessionStore` read the TTL via `->get('session.ttl')` (nested),
while the config key is the flat `session_ttl`; the read misses, so the stores fall back to a
hardcoded 86400 s. The configured value is effectively not applied.

## Resource plugin settings

- Route: **`mcp_server.resource_plugin_settings`** → `/admin/config/services/mcp-server/resources`
  (`_permission: 'administer mcp server'`). Form `ResourcePluginSettingsForm` (form id
  `mcp_server_resource_plugin_settings`), editable config **`mcp_server.resource_plugins`**.
- Enable/disable `ResourceTemplate` plugins here and set per-plugin `configuration`. Only entries
  with `enabled: true` are registered by `McpServerFactory::registerResources()`. Saving invalidates
  cache tag `mcp_server:discovery`. See [../plugins/resources.md](../plugins/resources.md).

## Prompts (CRUD)

- Collection `entity.mcp_prompt_config.collection` → `/admin/config/services/mcp-server/prompts`;
  add/edit/delete forms under `/prompts/…`. All require `administer mcp prompt configurations`.
- Config entity `mcp_prompt_config` (`McpPromptConfig`). See
  [../plugins/prompts.md](../plugins/prompts.md).

## Tools (bridge, if `mcp_server_tool_bridge` enabled)

- Collection `entity.mcp_tool_config.collection` → `/admin/config/services/mcp-server/tools`
  (+ add/edit/delete, + autocomplete). All require `administer mcp tool configurations`. See
  [../plugins/tools.md](../plugins/tools.md).

## Permissions (real machine names)

| permission | defined in | restrict access | gates |
|---|---|---|---|
| `access mcp server` | `mcp_server.permissions.yml` | yes (ungranted by default) | the `/_mcp` route |
| `access mcp server prompts` | `mcp_server.permissions.yml` | no | title: "Discover and view enabled MCP prompts" |
| `administer mcp server` | `mcp_server_ui.permissions.yml` | yes | settings + resources pages |
| `administer mcp prompt configurations` | `mcp_server_ui.permissions.yml` | yes | prompt CRUD |
| `administer mcp tool configurations` | `mcp_server_tool_bridge.permissions.yml` | yes | tool-config CRUD (also the `admin_permission` of `mcp_tool_config`) |

To grant HTTP access to a role: `ddev drush role:perm:add <role> 'access mcp server'`. Because every
tool call executes as the authenticated Drupal account, grant `access mcp server` only to a role with
the narrowest permission set the client's tasks need.
