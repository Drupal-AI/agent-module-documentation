<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sitemap tools

Plugins in `src/Plugin/tool/Tool/`, all `MCP_CATEGORY = 'sitemap'` → permission
**`mcp_tools use sitemap`**. Read ops need read scope; Write ops need write scope, a
non-read-only connection, and a write-kind the connection's policy allows. Each delegates to
`mcp_tools_sitemap.sitemap` (`SitemapService`).

| Tool id | Class | Op | Write-kind | Destructive | Inputs | Does |
|---|---|---|---|---|---|---|
| `mcp_sitemap_status` | `GetStatus` | Read | - | - | - | Reports generation status and per-variant link counts. |
| `mcp_sitemap_list` | `ListSitemaps` | Read | - | - | - | Lists sitemap variants. |
| `mcp_sitemap_get_settings` | `GetSettings` | Read | - | - | variant? | Returns settings for a sitemap variant. |
| `mcp_sitemap_entity_settings` | `GetEntitySettings` | Read | - | - | entity_type, bundle? | Returns per-entity-type/bundle inclusion settings. |
| `mcp_sitemap_update_settings` | `UpdateSettings` | Write | config | - | variant, settings (map) | Updates a variant's settings. |
| `mcp_sitemap_set_entity` | `SetEntitySettings` | Write | config | - | entity_type, bundle, settings (map) | Sets inclusion/priority/changefreq for an entity bundle. |
| `mcp_sitemap_regenerate` | `Regenerate` | Write | ops | yes | variant? | Regenerates one or all sitemap variants. |

## Notes

- Settings writes default to config write-kind; `Regenerate` overrides to ops write-kind (a runtime action, not a config change).
- Mutating methods re-check `AccessManager::canWrite()`; read methods re-check `canRead()`.
