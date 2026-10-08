# Next And Previous Link (nextpre) — agent index

One block plugin that renders next/previous node links on a node detail page, scoped to a chosen
content type. No config UI page (`configure` null), no permissions, no Drush, no config schema
(settings live on the block instance). Depends on core `node`.

- **The `next_previous_block`: settings, how it selects the neighbouring node, output markup, and
  caching** → [configure/block.md](configure/block.md)

Key facts:
- Block id `next_previous_block` ("Next Previous link", category *Blocks*),
  `src/Plugin/Block/NextPreviousBlock.php`.
- Neighbour selection is by **node id**: previous = max `nid` `<` current; next = min `nid` `>`
  current. Filters: `type = <bundle>`, `status = 1`, `langcode = current`, `accessCheck(TRUE)`,
  range 0,1.
- Only renders when the current route's `node` param is a node of the configured `content_type`.
- Cache: `route` context + `node:*` tags.
