<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Map Widget adds an interactive Leaflet map facet that shows search results as a clustered heatmap and lets users narrow a geo-spatial Search API search by panning/zooming the map (its bounding box becomes the search area).

---

The submodule plugs into the **Facets** module to provide a spatial facet for Search API. It ships three plugins: a Facets **widget** (`rpt`, "Interactive map showing the clustered heatmap") that renders a `<div class="facets-map">` and attaches the `facets_map_widget/facets_map` Leaflet library plus the results as `drupalSettings`; a Facets **processor** (`rpt`, "Facets Map Processor") that rewrites each result URL to carry the map's bounding box as a `(geom:__GEOM__)` query filter; and a Facets **query type** (`search_api_rpt`, "RecursivePrefixTree Type") that turns the map's bounding box into a Search API spatial facet query (defaulting to the whole world `["-180 -90" TO "180 90"]`). A `hook_facets_search_api_query_type_mapping_alter()` only registers the `search_api_rpt` query type for a backend when that backend `supportsDataType('rpt')`, so the facet requires the source field to be indexed with Search API Location's **`rpt`** data type and a backend that supports it (**Solr**). The map widget requires the `rpt` processor (it declares it required). The Leaflet, MarkerCluster, geostats and leaflet-hash libraries are loaded from external CDNs (no local/composer library), so the map needs internet access to those hosts. Configure it on a facet at `facets.overview`.

---

- Show search results as a clustered heatmap on an interactive map.
- Let users filter results by dragging/zooming the map to a region (bounding-box search).
- Add a "search this area" spatial facet to a Solr-backed Search API search.
- Visualise the geographic density of results (stores, events, listings) at a glance.
- Combine a map facet with keyword search and other facets on the same search page.
- Cluster many nearby result markers so the map stays readable at low zoom.
- Drive the facet from a geofield indexed as the `rpt` (Recursive Prefix Tree) data type.
- Provide a map-based alternative to a numeric distance filter.
- Update results live as the user pans/zooms (bounding box sent to the backend).
- Deep-link a map state via the leaflet-hash integration in the URL.
- Offer a full-world default view that narrows as the user zooms in.
- Pair with search_api_location_views for both a map facet and a distance sort.
- Build a real-estate "map search" page where the visible area is the query.
- Add spatial faceting to an events calendar/search.
- Let site visitors explore a directory geographically instead of by list.
- Use the rpt query type to request a spatial heatmap facet from Solr.
- Show heatmap intensity buckets computed client-side via geostats.
- Restrict a faceted search to a metro area by zooming the map there.
- Provide an embeddable map facet block alongside a search results view.
- Complement text facets (category, price) with a geographic one.
