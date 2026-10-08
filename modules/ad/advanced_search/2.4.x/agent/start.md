<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Search (advanced_search) — agent index

Islandora-ecosystem search UI layer on top of **Search API Solr** + **Facets**. Adds an Advanced
Search block (multi-row field/boolean query builder), a simple global Search block, and a Search
Results Pager block (per-page count, list/grid toggle, sort, pager), plus AJAX refresh of
facet/pager/exposed-filter blocks and recursive sub-collection search. It rewrites the Solr query
(eDisMax) rather than the Search API query.

Dependencies: `facets:facets`, `facets:facets_summary`, `search_api_solr:search_api_solr`.
Configure route: **`advanced_search.settings`** → `/admin/config/search/advanced` (permission
`administer site configuration`). No permissions of its own, no Drush, defines no new plugin types.

- **Global settings form (config object + all keys, drush/PHP)** → [configure/settings.md](configure/settings.md)
- **The three blocks it provides and their per-block settings** → [blocks/blocks.md](blocks/blocks.md)
- **How the Solr query is rewritten / URL query params / recursive search** → [api/query.md](api/query.md)
- **Views integration: list-grid toggle, AJAX block refresh, library overrides** → [views/integration.md](views/integration.md)
- **Hooks it implements that affect integrators** → [hooks/hooks.md](hooks/hooks.md)
- **Facets Summary processor plugins it adds** → [plugins/facets_summary.md](plugins/facets_summary.md)
- **Field formatters it adds** → [fields/formatters.md](fields/formatters.md)

Key facts:
- Config object `advanced_search.settings` (schema `advanced_search.schema.yml`); constants live on
  `Drupal\advanced_search\Form\SettingsForm` (`CONFIG_NAME`). Keys: `lucene_on_off`, `lucene_label`,
  `all_fields_on_off`, `list_on_off`, `grid_on_off`, `default-display-mode`, `search_query_parameter`,
  `search_recursive_parameter`, `search_add_operator`, `search_remove_operator`, `facet_truncate`,
  `recursive`, `query_fields`, `no_follow`.
- Blocks: `advanced_search_block` and `advanced_search_result_pager` (both **derived per Search API
  display**, category "Islandora"); `search_block` (global simple search, admin_label "Search").
- Query mechanism: `PostConvertedQueryEventSubscriber` on `SearchApiSolrEvents::POST_CONVERT_QUERY`
  → `Drupal\advanced_search\AdvancedSearchQuery::alterQuery()`; URL params `a[N][f|v|i|c]` (search
  terms) and `r` (recurse). Recursive views handled in `hook_views_pre_view` via `alterView()`.
- Facets Summary processors: `show_active_facets`, `show_missing_facets`, `show_search_query`,
  `reset_remove_page`. Field formatters: `entity_reference_url_title`, `searchable_entity_formatter`.
- AJAX block-refresh route `advanced_search.ajax.blocks` → `/islandora-advanced-search-ajax-blocks`
  (`AjaxBlocksController::respond`).
