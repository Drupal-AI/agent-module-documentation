<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Content — agent index

Submodule of [Model Context Protocol](../../../../1.0.x/agent/start.md). Provides one `mcp` plugin,
`content` (id `content`), exposing Drupal node content types/nodes as MCP resources and a
`search-content` tool. Depends on `mcp` + `node`. Reached through the parent's `/mcp/get` +
`/mcp/post` endpoints (gated by `access content`).

- **The `content` plugin: resources, templates, `search-content` tool, supported fields, config** →
  [plugins/content.md](plugins/content.md)

Key facts:
- Resource `content://node/{type}` = content-type field metadata; template
  `content://node/{type}/{id}` = one node's supported field values (JSON).
- Tool `content_search-content` runs an entity query with field filters, paging, sort.
- Supported fields: `title`, `body`, and `field_*` of type
  `string|string_long|list_string|datetime|boolean|text_long`.
- Config `content_types` (per-plugin, `/admin/config/mcp`) selects exposed types; all default on.
