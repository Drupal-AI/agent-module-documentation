<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_search_api — tool reference

All tools extend `McpToolsToolBase` (`MCP_CATEGORY = 'search_api'`), require the
`mcp_tools use search_api` permission, and delegate to `SearchApiService`
(`mcp_tools_search_api.search_api_service`). Category maps to the **ops** write-kind.

| Tool id | Class | Op | Purpose | Key inputs |
|---|---|---|---|---|
| `mcp_search_api_list_servers` | `ListServers` | Read | List all Search API servers + status. | — |
| `mcp_search_api_get_server` | `GetServer` | Read | Details of one server. | `id`* |
| `mcp_search_api_list_indexes` | `ListIndexes` | Read | List all indexes + status. | — |
| `mcp_search_api_get_index` | `GetIndex` | Read | Index fields, datasources, status. | `id`* |
| `mcp_search_api_status` | `GetIndexStatus` | Read | Indexing progress (total/indexed/remaining). | `id`* |
| `mcp_search_api_search` | `SearchContent` | Read | Keyword search returning ranked items. | `index`*, `keywords`*, `filters`, `limit`, `offset` |
| `mcp_search_api_index` | `IndexItems` | Write | Index a batch of pending items. | `id`*, `limit` |
| `mcp_search_api_reindex` | `ReindexIndex` | Write | Mark all items for reindexing. | `id`* |
| `mcp_search_api_clear` | `ClearIndex` | Write | Clear all indexed data from an index. | `id`* |

`*` = required. The three Write tools need `write` scope and are blocked under global read-only mode.

## Search behavior (`SearchContent` / `SearchApiService::search()`)

- Runs `$index->query()->keys($keywords)` on an enabled index; a disabled/missing index returns an
  error, not results.
- `filters` is a map applied as query conditions; each field name must match
  `^[a-z_][a-z0-9_]*$` and exist on the index (`$index->getField()`), otherwise it is skipped — no
  raw query string is built from caller input.
- `limit` is clamped to a max of 100; `offset` paginates.
- Result items expose `id`, `score`, and (when the original entity loads) `entity_type`, `bundle`,
  `entity_id`, `label`, `uuid`, canonical `url`, plus a `strip_tags`-ed `excerpt`. No full field
  contents are dumped.
- Access follows the index's own configuration for the execution user; the tool adds no
  access-bypass option.
