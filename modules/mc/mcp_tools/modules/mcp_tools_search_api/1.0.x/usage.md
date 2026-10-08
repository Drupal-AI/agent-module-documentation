MCP Tools - Search API adds nine Tool API plugins that let an AI assistant list and inspect Search API servers and indexes, run searches, and index, reindex, or clear indexes through the parent MCP Tools server.

---

This is one of MCP Tools' domain submodules. Enabling it registers nine `tool` plugins backed by `SearchApiService` (service `mcp_tools_search_api.search_api_service`): the reads `mcp_search_api_list_servers`, `mcp_search_api_get_server`, `mcp_search_api_list_indexes`, `mcp_search_api_get_index`, `mcp_search_api_status`, `mcp_search_api_search`; and the operational writes `mcp_search_api_index`, `mcp_search_api_reindex`, `mcp_search_api_clear`. Searches run through the target index's own query, so results reflect whatever that index exposes and its processors (including any content-access processor) for the execution user; only labels, scores, URLs, and stripped excerpts are returned, not full field dumps. It exposes no routes, config, or UI; the tools are reachable only through a connected MCP client or another Tool API consumer. Every call needs the `mcp_tools use search_api` permission and the connection scope for the operation — the three index-mutating tools need `write` scope and are subject to the global read-only mode; category `search_api` maps to the operational (ops) write-kind. Each call runs as the configured execution user and is audit-logged.

Turn this on when an assistant should query or maintain Search API from plain-English requests. See `agent/tools/search-tools.md`.

---
- List all Search API servers and their status.
- Get details about a specific search server.
- List all indexes with their status.
- Get an index's fields, datasources, and configuration.
- Check indexing progress (total / indexed / remaining) for an index.
- Run a keyword search against an index and get ranked results.
- Filter a search by indexed field values.
- Page through search results with limit/offset.
- Index a batch of pending items on an index.
- Mark an entire index for reindexing after a config change.
- Clear all indexed data from an index.
- Have the assistant find content by relevance rather than exact title.
- Diagnose why an index is behind by reading its status.
- Keep the tools hidden entirely by leaving this submodule disabled.
- Restrict a connection to `read` scope so only search and inspection tools work.
- Require `write` scope before an assistant may index, reindex, or clear.
- Gate the whole domain behind the `mcp_tools use search_api` permission.
- Block index mutations site-wide with the server's global read-only mode.
- Run the tools as a least-privilege execution account.
- Audit which search tools are exposed on the MCP status page.
