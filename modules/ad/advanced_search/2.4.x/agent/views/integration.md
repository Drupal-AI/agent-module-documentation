# Views & AJAX integration

The module makes a Search API Solr view behave like a live, filterable search page: list/grid
display, and AJAX refresh of the facet, pager and exposed-filter blocks when the query changes,
without a full page reload.

## Display toggle & attached libraries — `hook_preprocess_views_view`

`advanced_search_preprocess_views_view()` runs only for displays that have a Search Results Pager
block placed (matched via `Utilities::getPagerViewDisplays()`). It:

- Adds class `view-list` or `view-grid` to the view, from the `display` query parameter or the
  `default-display-mode` setting.
- Attaches libraries `advanced_search/advanced.search.pager` (CSS) and
  `advanced_search/advanced.search.facets_views_ajax` (JS `js/facets/facets-views-ajax.js`).

## Recursive contextual filter — `hook_views_pre_view`

`advanced_search_views_pre_view()` instantiates `AdvancedSearchQuery` and calls `alterView()` so a
recursive (`r=1`) request ignores the "immediate children" contextual filter. See
[api/query.md](../api/query.md).

## AJAX block refresh endpoint

Route `advanced_search.ajax.blocks` → `/islandora-advanced-search-ajax-blocks`, controller
`Drupal\advanced_search\Controller\AjaxBlocksController::respond()`. The JS
(`js/facets/facets-views-ajax.js`) collects the ids of the on-page pager
(`block-plugin-id--islandora-advanced-search-result-pager`), views exposed filter
(`views-exposed-filter-block`) and facet (`block-facets`) blocks and POSTs them as `blocks`
(id → CSS selector) plus the current `link`. The controller rebuilds the request context for that
path and returns an `AjaxResponse` of `ReplaceCommand`s that re-render each requested block. This is
what keeps facets, the pager and the exposed filter in sync after a facet click or pager change.

## Overriding facets' JavaScript — `hook_library_info_alter`

`advanced_search_library_info_alter()` replaces two facets-module libraries with the module's own
copies so the AJAX/soft-limit behavior integrates with the pager:

- `facets/soft-limit` → `js/facets/soft-limit.js`
- `facets/drupal.facets.views-ajax` → `js/facets/facets-views-ajax.js`
