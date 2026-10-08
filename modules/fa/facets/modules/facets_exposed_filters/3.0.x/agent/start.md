# facets_exposed_filters — agent start

Facets submodule. Renders facets as **Views exposed filters** instead of blocks. Requires
`facets`, `search_api`, `views`, `better_exposed_filters`. Configure inside the view's
exposed-filter form; facets are still defined at `/admin/config/search/facets`.

Key source (no new plugin type; it plugs into Search API + Views):
- `src/Plugin/views/filter/FacetsFilter.php` — the exposed Views filter.
- `src/Plugin/search_api/display/ViewsDefault.php`, `ViewsAttachment.php` — facet sources for view displays.
- `src/ExposedFacetBuildState.php` — build-state glue.
- Config schema: `config/schema/facets_exposed_filters.views.schema.yml`.

No admin config UI of its own, no permissions, no hooks — trivial glue module; use the main
facets docs for facet/widget/processor configuration.
