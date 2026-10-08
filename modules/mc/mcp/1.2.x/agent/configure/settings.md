<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings (`mcp.settings`) — auth, plugins, tools

Config object `mcp.settings` (schema `config/schema/mcp.schema.yml`). Two admin surfaces:
`SettingsForm` at `/admin/config/mcp` (auth) and `McpPluginSettingsForm` at
`/admin/config/mcp/plugins/{plugin}/settings` (per-plugin). Both need `administer mcp configuration`.
`mcp.info.yml` sets `configure: mcp.settings`; menu link "MCP Configuration" under
`system.admin_config_services`. There is also `/admin/config/mcp/plugins` (list) and
`/admin/config/mcp/connection` (copy-paste client config for Claude Desktop / Claude Code / Cursor).

```yaml
mcp.settings:
  enable_auth: false            # boolean; default off
  auth_settings:                # only meaningful when enable_auth is true
    enable_token_auth: false
    token_key: '<key_id>'       # a key module Key holding the shared secret
    token_user: '<uid>'         # Drupal user the token authenticates as
    enable_basic_auth: false
  plugins:                      # keyed by plugin id
    <plugin_id>:
      enabled: true
      roles: ['authenticated']  # empty = all authenticated users
      config: { ... }           # plugin-specific (e.g. content_types, allowed_resource_types)
      tools:                    # keyed by ORIGINAL tool name
        <tool_name>:
          enabled: true
          roles: []             # empty = fall back to plugin roles
          description: ''        # custom description shown to LLMs
```
Install default: `enable_auth: false`, `auth_settings: {}`, `plugins.general.{enabled:true, config:{}}`.

## Authentication form (`/admin/config/mcp`, `SettingsForm`)
- **Enable Auth** (`enable_auth`) — off by default. Its help states that when off "the server will allow
  clients to connect with anonymous permissions." (Route access still requires `use mcp server`.)
- **Enable Token Auth** — requires a **Secret key** (`key_select`, a Key entity) and a **Token User**
  (`entity_autocomplete`). Validation enforces both when token auth is on. A client sends the raw token as an
  `Authorization: Basic <base64(token)>` value with no colon.
- **Enable Basic Auth** — username:password Basic auth; acts as that Drupal user with their role permissions.
- **OAuth** — informational: if an OAuth2 provider is configured, clients can use it (no settings here).
- Validation: if auth is enabled, at least one of token/basic must be selected.

## Per-plugin form (`/admin/config/mcp/plugins/{plugin}/settings`, `McpPluginSettingsForm`)
- **Enable plugin** (`plugins.<id>.enabled`).
- **Allowed roles** (`plugins.<id>.roles`) — which roles may use this plugin; empty = all authenticated.
- **Additional Configuration** — the plugin's own `buildConfigurationForm()` (e.g. `content` → content-type
  checkboxes; `jsonapi` → allowed resource types).
- **Tool Settings** — one details section per tool with: **Enabled**, an info block showing the original name +
  the machine name sent to the LLM (`generateToolId`) + any behavior-hint annotations, a **Custom Description**
  (overrides what LLMs see), and per-tool **Allowed roles** (empty = inherit plugin roles).

## Reading config in code
- `McpPluginManager::createInstance()` merges `mcp.settings:plugins.<id>` over the defaults
  `{enabled:true, roles:['authenticated'], config:[], tools:[]}`.
- `getAvailablePlugins($getDisabled=false, $getRestricted=false)` returns plugins passing
  `checkRequirements()` and (unless overridden) `isEnabled()` and `hasAccess()`.
- `$plugin->isEnabled()` reads `configuration['enabled']`; `isToolEnabled($name)` / `getToolAllowedRoles($name)`
  read `configuration['tools'][$name]`.
