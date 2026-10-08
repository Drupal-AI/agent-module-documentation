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

## Diff 1.2.x → 1.3.x

Maintenance-only release (`8.x-1.3`, packaged 2026-08-21). No changes to the config entity
shape, block/deriver, event subscriber, service, routes, permissions, or the alter hooks — the
API and configuration surface documented here are unchanged.

- **PHP 8.4 compatibility** (#3534957) — code modernised to run cleanly on PHP 8.4.
- **Tabledraggers restored on the Manage sort fields form** (#3617951) — the weight-column drag
  handles that had gone missing on the `ManageSortFieldsForm` table work again (the `#tabledrag`
  / `search-api-sort-order-weight` weight column).
- **Unresolved dependency error fixed** (#3606451).
- **Test suite fixed against current Drupal core** (#3618059).

`core_version_requirement` stays `^9.2 || ^10 || ^11`; the only dependency remains
`search_api:search_api` (`drupal/search_api:^1.16`).
