# Find Text — agent index

Admin/editor tool to search all text fields for a string or regex directly against the DB, showing the
entity, field, and highlighted match. Search form at `/admin/find-text` (`access find text`), settings at
`/admin/config/find-text/settings` (`administer find text configuration`). Both permissions are
`restrict access: true`. Depends on core `node`.

- **Settings: searchable field types, entity types/bundles, tables to skip, render mode, caching, CSV** →
  [configure/settings.md](configure/settings.md)
- **`TextSearchService` — how the search maps fields→tables and queries (LIKE vs REGEXP)** →
  [api/search.md](api/search.md)
- **`hook_find_text_results()` to filter/alter results** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Service `find_text.search` = `TextSearchService`; entry point `searchFields($needle, $regexed, $render, $langcode)`.
- Config object `find_text.settings` (see `config/install`): `field_types.*`, `entity_types.*`,
  `allow_all_entities`, `tables_to_skip`, `enable_search_results_cache`, `search_results_cache_duration`,
  `save_as_csv`.
- Plain search = `LIKE '%'.escapeLike(needle).'%'` (so `_`/`%` are wildcards); regexp mode = SQL `REGEXP`.
- No Drush. Permissions: `access find text`, `administer find text configuration` (both restricted).
