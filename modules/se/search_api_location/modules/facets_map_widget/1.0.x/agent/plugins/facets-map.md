<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets map plugins

Three Facets plugins that together make an interactive map heatmap facet for a Search API
`rpt`-typed field.

## Widget — `rpt`
`Plugin/facets/widget/RptMapWidget` (`@FacetsWidget id="rpt"`,
label "Interactive map showing the clustered heatmap"). `build()` outputs
`<div class="facets-map" id="<facet id>">` and attaches:
- library `facets_map_widget/facets_map`;
- `drupalSettings['facets']['map']` = `{ id, url: results[0] url, results: json_encode(raw value) }`.
- `getQueryType()` returns **`search_api_rpt`**.
- `isPropertyRequired('rpt', 'processors')` returns TRUE → the **`rpt` processor is required**.

## Processor — `rpt`
`Plugin/facets/processor/RptMapProcessor` (`@FacetsProcessor id="rpt"`, label "Facets Map
Processor", stage `build` weight 2). Implements `BuildProcessorInterface`. For each result it
rewrites the URL query to drop existing filters for the facet and append
`<url_alias><separator>(geom:__GEOM__)` — the placeholder the JS replaces with the current map
bounding box.

## Query type — `search_api_rpt`
`Plugin/facets/query_type/SearchApiRpt` (`@FacetsQueryType id="search_api_rpt"`, label
"RecursivePrefixTree Type"). `execute()` sets `options['search_api_facets'][<field>]` (limit =
hard limit, operator, min_count) and turns the active `(geom:…)` item into the spatial query;
default geom is the whole world `["-180 -90" TO "180 90"]`.

## Backend wiring
`facets_map_widget_facets_search_api_query_type_mapping_alter($backend_plugin_id, &$query_types)`
instantiates the backend and, **only if `$backend->supportsDataType('rpt')`**, sets
`$query_types['rpt'] = 'search_api_rpt'`. So the facet works only when the source field is
indexed as `rpt` and the backend (Solr) supports it.

## Set it up
1. Index a geofield with the **`rpt`** data type on a Solr-backed Search API index (parent module).
2. Create a Search API search display (a View or search page) → gives Facets a facet source.
3. At `/admin/config/search/facets`, add a facet on the `rpt` field.
4. Set the facet **widget** to *Interactive map showing the clustered heatmap* (`rpt`) and enable
   the **Facets Map Processor** (`rpt`). In config that is the `facets_facet` entity:
   `widget.type: rpt` and `processor_configs.rpt`.

## Libraries (external)
`facets_map` pulls Leaflet 1.1.0, leaflet.markercluster 1.0.6, geostats and leaflet-hash from
CDNs (`unpkg.com`, `cdnjs.cloudflare.com`, `intermezzo-coop.eu`). No composer/local asset — the
map needs outbound access to those hosts.
