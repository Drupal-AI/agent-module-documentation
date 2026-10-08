<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MCP Content is a submodule of Model Context Protocol that provides a `content` MCP plugin, exposing Drupal node content types and nodes as MCP resources and adding a `search-content` tool for querying nodes.

---

The submodule (depends on `mcp` and `node`) ships a single `#[Mcp(id: 'content')]` plugin, `Content`, that other MCP clients reach through the parent module's `/mcp/get` + `/mcp/post` endpoints. It advertises each enabled node type as an MCP resource (`content://node/{type}` — content-type field metadata) and a resource template (`content://node/{type}/{id}` — a single node's supported field values). `readResource()` loads a node by nid+type and returns its supported fields as JSON; supported fields are `title`, `body`, and `field_*` fields of type `string`, `string_long`, `list_string`, `datetime`, `boolean`, or `text_long`. The `search-content` tool runs an entity query over a chosen content type with an array of field filters (operators `=`, `<>`, `>`, `>=`, `<`, `<=`, `CONTAINS`, `STARTS_WITH`, `ENDS_WITH`, `IN`, `NOT IN`, `BETWEEN`, `IS NULL`, `IS NOT NULL`), limit/offset paging, and sort. Which content types are exposed is configurable per-plugin (`content_types` checkboxes on `/admin/config/mcp`; all types default to enabled).

---

- Expose all article/page/etc. content to an LLM client as MCP resources.
- Let an assistant read a single node's fields as JSON via `content://node/{type}/{id}`.
- Advertise a content type's field schema (name, type, required, multiple) to a client.
- Search nodes of a type with field filters combined via AND logic (`search-content` tool).
- Paginate search results with `limit` and `offset`.
- Sort search results by a supported field ascending or descending.
- Filter content with `CONTAINS` / `STARTS_WITH` / `ENDS_WITH` LIKE matching.
- Filter content with `IN` / `NOT IN` / `BETWEEN` / `IS NULL` / `IS NOT NULL` operators.
- Restrict which content types are exposed to MCP by unchecking them in plugin config.
- Feed published node bodies to an LLM as retrieval context.
- Build an AI content-discovery workflow over Drupal nodes.
- Return only "safe" text/date/boolean fields to a client (unsupported field types are filtered out).
- Let an assistant look up an article by title prefix and read its full body.
- Provide structured content-type metadata to an AI planning which fields to query.
- Expose editorial content to an IDE or chat assistant for summarization.
- Combine multiple field conditions to narrow an AI's content search.
- Serve `list_string` select-list values (e.g. status/category) to an LLM.
- Power a "find matching content" MCP tool for an agentic workflow.
