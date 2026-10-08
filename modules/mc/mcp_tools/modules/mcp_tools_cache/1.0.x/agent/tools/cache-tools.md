<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache tools

Plugins in `src/Plugin/tool/Tool/`, delegating to `mcp_tools_cache.cache_service`
(`CacheService`). `MCP_CATEGORY = 'cache'` → permission **`mcp_tools use cache`**, write-kind
**ops**.

| Tool id | Class | Op / scope | Inputs | Does |
|---|---|---|---|---|
| `mcp_cache_get_status` | `GetCacheStatus` | Read / read | — | Overview of cache bins and their backends. |
| `mcp_cache_clear_all` | `ClearAllCaches` | Write / write | — | `CacheService::clearAllCaches()` — full rebuild (drush cr equivalent). |
| `mcp_cache_clear_bin` | `ClearCacheBin` | Write / write | `bin` (string, required) | Clears one named bin (e.g. `render`, `page`, `entity`). |
| `mcp_cache_clear_entity` | `ClearEntityCache` | Write / write | `entity_type` (string, required), `entity_id` (string, required) | Invalidates that entity's cache tags. |
| `mcp_cache_invalidate_tags` | `InvalidateTags` | Write / write | `tags` (list, required) | Invalidates the given cache tags via `@cache_tags.invalidator`. |
| `mcp_cache_rebuild` | `RebuildCache` | Write / write | `type` (string, required) | Rebuilds one subsystem: `router`, `theme`, `container`, or `menu` (validated list). |

## Access enforcement

`McpToolsToolBase::checkAccess()` applies `mcp_tools use cache` + the operation scope + `ops`
write-kind policy + read-only switch. In `executeLegacy()`, each write tool re-calls
`AccessManager::checkWriteAccess('clear'|'invalidate'|'rebuild', 'cache')` — all map to the
generic **write** bucket (write scope). `RebuildCache` rejects any `type` outside
`['router','theme','container','menu']`.

## Notes

- These are site-global operational actions; there is no per-entity access check because a
  cache clear affects the whole site.
- `clear_all` / `rebuild container` are the heaviest — they rebuild the service container and
  optimizers.
