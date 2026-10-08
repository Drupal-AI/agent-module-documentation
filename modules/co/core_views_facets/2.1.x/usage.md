Core Views Facets is a Facets add-on that lets you build facets from an ordinary Views page's exposed or contextual filters — no Search API index required.

---

Enabling the module makes every Views **page** display that has an exposed and/or contextual filter appear (twice) as a Facets *facet source*: `core_views_exposed_filter:<view>__<display>` and `core_views_contextual_filter:<view>__<display>` (derived by `CoreViewsExposedFilterDeriver` / `CoreViewsContextualFilterDeriver`). To make facets actually work you must edit the facet source and switch its URL processor to **Core views url processor** (`core_views_url_processor`), which formats query URLs the way Views' exposed filters expect. You then add a Facet on that source (`/admin/config/search/facets/add-facet`) whose *field* is one of the view's exposed filters or contextual arguments, and place its block as usual. The module maps each Views filter/argument to a "filter type" plugin that knows how to build the facet's count query and render its values; it ships two plugin types (`core_views_facets_exposed_filter_types`, `core_views_facets_contextual_filter_types`) with implementations for taxonomy terms, node bundles, booleans and a generic fallback. It also keeps facet config consistent: `hook_entity_presave()` deletes facet sources and their facets when the underlying view display is removed, and it attaches an AJAX library so facet blocks refresh in-place on AJAX-enabled views. There is no settings form, permission or Drush command of its own; all state lives in Facets' `facets_facet` and `facets_facet_source` config entities plus the View.

---

- Add faceted navigation to a plain Views listing page without installing Search API.
- Turn a view's exposed "Content type" filter into a clickable facet block.
- Facet a taxonomy-term exposed filter (e.g. Tags/Categories) on a Views page.
- Build a boolean facet (e.g. Published / Promoted) from an exposed boolean filter.
- Facet a Views **contextual** filter (URL argument) such as node type in the path.
- Provide facet blocks alongside an existing catalogue/directory view.
- Reuse a site's existing SQL-backed view for faceting instead of building a search index.
- Combine several exposed filters of one view as independent facets.
- Let visitors drill down a product/article list by multiple attributes at once.
- Offer AJAX-refreshing facets on an AJAX-enabled view (in-place updates, no full reload).
- Add a facet source for both exposed and contextual filters of the same view display.
- Assign the required `core_views_url_processor` so facet links round-trip through Views correctly.
- Create a facet on a specific exposed-filter field via the Facets add-facet UI.
- Map a custom Views filter to a facet by writing a `CoreViewsFacetsExposedFilterType` plugin.
- Map a custom Views contextual argument to a facet with a `CoreViewsFacetsContextualFilterType` plugin.
- Render term facets with their labels using the shipped taxonomy_index_tid filter type.
- Present node-bundle facets with the bundle/node_type filter types.
- Keep facets tidy: they are auto-removed when their view display is deleted.
- Migrate a Search-API-facet setup to a lighter core-Views-based one where an index is overkill.
- Add multilingual-safe facets by adding a language filter to the underlying view.
- Expose the same view as a faceted page in multiple displays, each its own facet source.
