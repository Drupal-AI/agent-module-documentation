# Search API Sorts — agent index

Exposes clickable **sort options** for a Search API **display**. State lives in
`search_api_sorts_field` config entities; a derived block renders the sort links; an event
subscriber applies the active/default sort to the query. No settings form (`configure=null`);
the UI is a "Manage sort fields" form per display. Guarded by core `administer search_api`.

- **Config entity shape, the admin form/route, how to create sort fields in code/Drush** →
  [configure/sort-fields.md](configure/sort-fields.md)
- **The derived sort block, URL params (`?sort`/`?order`), theming the sort links** →
  [theming/sort-block.md](theming/sort-block.md)
- **Alter the active/default sort in code** →
  [hooks/alter-sort.md](hooks/alter-sort.md)

Key facts:
- Config entity `search_api_sorts_field`, id = `{escaped_display_id}_{field_identifier}`
  (display id colons `:` are escaped to `---`). Config name
  `search_api_sorts.search_api_sorts_field.<id>`.
- Fields: `display_id`, `field_identifier`, `status`, `default_sort`, `default_order`
  (`asc|desc`), `label`, `weight`.
- Block: `search_api_sorts_block` (deriver `SearchApiSortsBlockDeriver`, one per display);
  `getCacheMaxAge()` = 0 (use BigPipe).
- Service `search_api_sorts.manager` (`SearchApiSortsManagerInterface`); subscriber
  `SearchApiSortsQueryPreExecute` on the Search API query-pre-execute event.
- Admin route `search_api_sorts.search_api_display.sorts` at
  `/admin/config/search/search-api/index/{index}/sorts/{display}`.
