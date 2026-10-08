# Hooks implemented

All in `advanced_search.module`. These matter to integrators theming or extending an
Islandora/Search API Solr search page.

| Hook | What it does |
|---|---|
| `hook_theme` | Registers `facets_result_item__summary` (template `templates/facets/facets-result-item--summary.html.twig`, base hook `facets_result_item`) — used by the module's Facets Summary processors. |
| `hook_library_info_alter` | For the `facets` extension, swaps `soft-limit` and `drupal.facets.views-ajax` JS for the module's versions. See [views/integration.md](../views/integration.md). |
| `hook_form_block_form_alter` (`advanced_search_form_block_form_alter`) | Re-adds the `node_has_term` visibility condition to the block configuration form (Islandora removes it), so a block can be shown only for nodes with a given term — e.g. collection-only blocks. The condition's `term` is made non-required. |
| `hook_preprocess_block__facets_summary` | Copies the block's `data-*` attributes onto `content_attributes` because the AJAX JS expects the data declaration to sit directly on the content element. |
| `hook_preprocess_views_view` | List/grid class + attaches pager/AJAX libraries (pager-block displays only). See [views/integration.md](../views/integration.md). |
| `hook_views_pre_view` | Enables recursive sub-collection search via `AdvancedSearchQuery::alterView()`. See [api/query.md](../api/query.md). |
| `hook_preprocess_facets_result_item` | Truncates a facet result's display value to `facet_truncate` characters (`Unicode::truncate`, default 32) when that setting is numeric. |
