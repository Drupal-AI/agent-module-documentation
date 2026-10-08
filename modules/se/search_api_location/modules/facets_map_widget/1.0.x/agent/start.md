<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Map Widget — agent index

A **Facets** map facet for Search API: an interactive Leaflet heatmap whose bounding box becomes
the search area. Provides three Facets plugins and requires a field indexed as Search API
Location's **`rpt`** data type on a backend that supports it (**Solr**). Configure on a facet at
`facets.overview`.

- **The three Facets plugins, the query-type mapping, the map/Leaflet library, requirements** →
  [plugins/facets-map.md](plugins/facets-map.md)

Key facts:
- Facets **widget** id **`rpt`** ("Interactive map showing the clustered heatmap") —
  `getQueryType()` = `search_api_rpt`; requires the `rpt` processor.
- Facets **processor** id **`rpt`** ("Facets Map Processor") — adds the map bounding box to each
  result URL as `(geom:__GEOM__)`.
- Facets **query type** id **`search_api_rpt`** ("RecursivePrefixTree Type") — default geom is the
  whole world `["-180 -90" TO "180 90"]`.
- `hook_facets_search_api_query_type_mapping_alter()` registers `search_api_rpt` only when the
  backend `supportsDataType('rpt')`.
- Library `facets_map_widget/facets_map` loads Leaflet + MarkerCluster + geostats + leaflet-hash
  from **external CDNs** (needs internet). No composer library, no config schema, no permissions.
- Verify a facet uses it: the `facets_facet` config entity's `widget.type === 'rpt'` and its
  `processor_configs` contains `rpt`.
