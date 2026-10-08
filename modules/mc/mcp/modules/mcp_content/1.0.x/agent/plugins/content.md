<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `content` MCP plugin

`Drupal\mcp_content\Plugin\Mcp\Content` — `#[Mcp(id: 'content')]`. `checkRequirements()` requires the
`node` module.

## Resources & templates
- `getResources()` → one `Resource` per **enabled** node type, URI `node/{type}` (prefixed to
  `content://node/{type}` by the parent service), mimeType `application/json`.
- `getResourceTemplates()` → one `ResourceTemplate` per enabled type, `node/{type}/{id}`.
- `readResource($resourceId)` (called via JSON-RPC `resources/read`, uri `content://…`):
  - `node/{type}` → `readContentTypeInfo()`: returns the type's supported-field schema
    (`name`, `type`, `description`, `required`, `multiple`).
  - `node/{type}/{id}` → `readNodeContent()`: loads the node by `nid`+`type` and returns its supported
    non-empty field values as JSON (`JSON_UNESCAPED_UNICODE`; multi-value fields become arrays).
  - Invalid format or disabled type → `InvalidArgumentException`.

## Tool: `search-content` (called `content_search-content` externally)
`executeTool('search-content', $arguments)` → `searchContent()`. Input schema (required
`contentType`, `filters`):
- `contentType` (string) — machine name; must be an enabled type.
- `filters` (array of `{field, value, operator?}`) — combined with **AND**. Operators: `=`, `<>`, `>`,
  `>=`, `<`, `<=`, `CONTAINS`/`STARTS_WITH`/`ENDS_WITH` (mapped to `LIKE` with `%`), `IN`, `NOT IN`,
  `BETWEEN` (needs a 2-element array), `IS NULL` (`notExists`), `IS NOT NULL` (`exists`), default `=`.
  Each `field` must be a **supported** field or it throws `Unknown field`.
- `limit` (int, default 10), `offset` (int, default 0), `sort` (`{field, order: ASC|DESC}`).

The query is fixed to `condition('status', 1)` (published) and `sort('created','DESC')` before filters.
Results are returned as MCP `resource` items, each the node's `readNodeContent()` output.

## Supported fields (`isSupportedField()`)
`title` and `body` always; any `field_*` whose type is one of
`string, string_long, list_string, datetime, boolean, text_long`. Everything else (references,
numbers, files, links, etc.) is excluded from both reads and filters.

## Config
`buildConfigurationForm()` renders a checkbox per node type under `content_types`
(`/admin/config/mcp` → Content tab). `defaultConfiguration()` enables **all** existing node types.
`isContentTypeEnabled($type)` returns `config.config.content_types[$type] ?? TRUE` (unknown/new types
default enabled).
