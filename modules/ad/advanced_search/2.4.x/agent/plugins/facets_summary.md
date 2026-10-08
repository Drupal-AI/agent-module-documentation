# Facets Summary processor plugins

These are **implementations** of the `facets_summary` `@SummaryProcessor` plugin type (provided by
the `facets_summary` module), not a new plugin type. Enable them per Facets Summary at
`admin/config/search/facets` on the summary's edit form. They render items with the module's
`facets_result_item__summary` theme (see [hooks/hooks.md](../hooks/hooks.md)).

| Plugin id | Class | Build stage | What it adds to the summary |
|---|---|---|---|
| `show_active_facets` | `ShowActiveFacets` | build 20 | Re-adds active facet items that other processors (e.g. `hide_active_items_processor`) removed, so the active selection always shows in the summary. Rebuilds results via `facets.manager`. |
| `show_missing_facets` | `ShowMissingFacets` (uses `ShowFacetsTrait`) | build 20 | Shows facet values that are present in the URL but absent from the Solr result (non-excluded facets with empty results), each linking to a URL with that value removed. |
| `show_search_query` | `ShowSearchQueryProcessor` | build 40 | Renders the current fulltext query (`search_api_fulltext`) as a summary item and ensures a "Reset" link exists (or strips the query from the existing reset link). |
| `reset_remove_page` | `ResetRemovePage` (extends `ShowSearchQueryProcessor`) | build 45 | Removes the `page` query parameter from the Reset link so resetting returns to page 1. |

`ShowFacetsTrait::buildHelper()` is the shared logic for building "removable" summary items: it reads
the facet's filter key (default `f`) and URL alias and produces a link that drops the given active
value from the query.
