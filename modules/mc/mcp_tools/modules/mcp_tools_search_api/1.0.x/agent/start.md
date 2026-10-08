<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Search API (mcp_tools_search_api) — agent index

Submodule of **mcp_tools**. Adds nine Tool API plugins for inspecting Search API servers/indexes,
searching, and running index maintenance, callable by an AI assistant through the parent's MCP
server. Version **1.0.0-beta8** (dir `1.0.x`). Core `^10.3 || ^11 || ^12`.
Depends on: `mcp_tools:mcp_tools`, `search_api:search_api`.
Permission: **`mcp_tools use search_api`** (`restrict access: true`). No routes, config, or UI.

- **The nine tools, ids, ops, and inputs** → [tools/search-tools.md](tools/search-tools.md)

## What it provides

- Nine `#[Tool]` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase`
  (`MCP_CATEGORY = 'search_api'`). Reads: `ListServers` (`mcp_search_api_list_servers`), `GetServer`
  (`mcp_search_api_get_server`), `ListIndexes` (`mcp_search_api_list_indexes`), `GetIndex`
  (`mcp_search_api_get_index`), `GetIndexStatus` (`mcp_search_api_status`), `SearchContent`
  (`mcp_search_api_search`). Writes: `IndexItems` (`mcp_search_api_index`), `ReindexIndex`
  (`mcp_search_api_reindex`), `ClearIndex` (`mcp_search_api_clear`).
- Service `SearchApiService` (`mcp_tools_search_api.search_api_service`,
  `src/Service/SearchApiService.php`) holding all logic.
- No permissions beyond the one above, no Drush, no config schema, no hooks.

## Search access note

`SearchContent` executes the index's own `->query()` — it does not set a bypass-access option and
does not disable processors, so result visibility follows whatever the index is configured to expose
(e.g. a content-access processor, if enabled) for the execution user. Filter field names are
validated against a `^[a-z_][a-z0-9_]*$` pattern and must exist on the index; `limit` is capped at
100. Only `id`, `score`, entity type/id/label/uuid, canonical URL, and a `strip_tags`-ed excerpt are
returned.

## Access model

`McpToolsToolBase::checkAccess()` = `mcp_tools use search_api` permission + connection scope (read
for the six read tools; `write` for index/reindex/clear) + write-kind policy. Category `search_api`
maps to the **ops** write-kind, and the write tools are blocked under global read-only mode. Every
call runs as the configured execution user and is audit-logged. See [[mcp_tools]] for the model.
