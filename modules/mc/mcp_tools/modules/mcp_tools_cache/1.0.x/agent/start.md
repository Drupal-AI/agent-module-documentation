<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Cache (mcp_tools_cache) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins for cache management — clear all caches,
clear a bin, invalidate tags, clear one entity's render cache, rebuild a subsystem, and read
cache status — from an MCP/AI connection. Package *MCP Tools*. Core `^10.3 || ^11 || ^12`.
Depends on **mcp_tools** only. No routes, forms, or config of its own.

- **The six tools, inputs/outputs, scopes and enforcement** →
  [tools/cache-tools.md](tools/cache-tools.md)

## What it provides

- Six `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` with
  `MCP_CATEGORY = 'cache'`: `GetCacheStatus` (`mcp_cache_get_status`, Read), `ClearAllCaches`
  (`mcp_cache_clear_all`, Write), `ClearCacheBin` (`mcp_cache_clear_bin`, Write),
  `ClearEntityCache` (`mcp_cache_clear_entity`, Write), `InvalidateTags`
  (`mcp_cache_invalidate_tags`, Write), `RebuildCache` (`mcp_cache_rebuild`, Write).
- One service `mcp_tools_cache.cache_service` (`Service/CacheService.php`) over
  `@cache_tags.invalidator`, `@cache_factory`, `@router.builder`, `@theme.registry`, the CSS/JS
  collection optimizers, `@kernel`, `@plugin.manager.menu.link`, `@database`, and the container.
- One permission: **`mcp_tools use cache`** (`restrict access: true`).

## Access model (inherited)

Gated by `McpToolsToolBase::checkAccess()` — `mcp_tools use cache` + operation scope
(Read→read, Write→write) + write-kind (`cache` → **ops**) + read-only switch. Write tools
re-check `AccessManager::checkWriteAccess()` in `executeLegacy()`. See
[tools/cache-tools.md](tools/cache-tools.md).

## Operate

```bash
drush en mcp_tools_cache -y
```

Grant `mcp_tools use cache` to the executor role.
