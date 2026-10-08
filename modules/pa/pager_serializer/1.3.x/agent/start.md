# Pager Serializer — agent index

Adds a Views **REST-export style plugin** `pager_serializer` (extends core REST `Serializer`)
that outputs serialized rows **plus** a pager object (current_page, total_items, total_pages,
items_per_page). Depends on core `rest`. All keys/flags come from config object
**`pager_serializer.settings`** (form route `pager_serializer.settings` →
`/admin/config/pager_serializer`; reset route `pager_serializer.settings.reset`). Permission:
core *administer site configuration*. No own permission, no Drush, no new plugin type.

- **Use the style on a REST export, the output shape, None/Some pager handling** →
  [plugins/views-style.md](plugins/views-style.md)
- **All config keys (labels + enable flags) and drush cget/cset** →
  [configure/settings.md](configure/settings.md)
- **Modify each output row** → [hooks/row-alter.md](hooks/row-alter.md)

Key fact: output is `{ <rows_label>: [...], <pager_label>: { current_page, total_items,
total_pages, items_per_page } }` by default; set `pager_object_enabled=false` to flatten the
pager fields onto the top level.
