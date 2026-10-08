<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings (`mcp.settings`)

Form `SettingsForm` at `/admin/config/mcp` (route `mcp.settings`, `administer site configuration`).
Config object `mcp.settings` (schema `config/schema/mcp.schema.yml`):

```yaml
mcp.settings:
  enable_sse: true            # boolean; default TRUE when unset (controller falls back to TRUE)
  plugins:                    # sequence keyed by plugin id
    <plugin_id>:
      id: <plugin_id>
      settings:
        enabled: true         # boolean
        config: { ... }       # plugin-specific mapping
```

Note: the form actually stores each plugin under `plugins.<id>` = the plugin's full configuration array
(`{enabled: bool, config: {...}}`) as returned by `McpPluginBase::getConfiguration()`.

## Fields
- **Enable HTTP SSE** (`enable_sse`) — when on, Drupal acts as the MCP server directly over
  Server-Sent Events (`/mcp/get` stream + session-validated `/mcp/post`). When off, `/mcp/post`
  returns JSON-RPC responses directly and `/mcp/get` is disabled. Default on.
- **Per-plugin section** — one vertical tab per discovered plugin (`getAvailablePlugins(TRUE)` includes
  disabled ones). Each has an **Enable** checkbox and, if the plugin's `buildConfigurationForm()`
  returns fields, an "Additional Configuration" details element (shown only when enabled). Plugins with
  no custom config show "No additional configuration options available."

## Reading config in code
- A plugin's config is merged in by `McpPluginManager::createInstance()` from `mcp.settings:plugins.<id>`.
- `$plugin->isEnabled()` reads `configuration['enabled']` (defaults TRUE if unset).
- Disabling a plugin here removes its tools/resources from `tools/list` etc. (aggregation only includes
  plugins where `checkRequirements() && isEnabled()`).

There is no `configure` key in `mcp.info.yml`; reach the form via the `system.admin_config_services`
menu link ("MCP Configuration") or the route directly.
