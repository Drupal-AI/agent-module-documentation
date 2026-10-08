<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API OpenSearch Location adds a `location` (geopoint) Search API data type so geofield latitude/longitude values can be indexed into OpenSearch as a geo_point and used for geospatial search.

---

This submodule of Search API OpenSearch provides a Search API data type plugin with id `location` (label "Geopoint"), backed by the `geofield` module's GeoPHP service. When you add a geofield-based field to a Search API index and set its type to `location`, the value is treated as a geographic point (latitude/longitude) that maps to an OpenSearch `geo_point`. An event subscriber (`DataTypeEventSubscriber`) listens to the parent module's `SupportsDataTypeEvent` and marks the `location` type as supported by the OpenSearch backend, so the backend accepts and maps it. The module is deliberately tiny: it has no settings page, no permissions, no config schema and no plugin types of its own — it just contributes the data type and the support declaration. It depends on `search_api_opensearch` and `geofield`. Actual geo_point indexing and geo-distance queries require a live OpenSearch cluster; on a site without one you configure the field's data type in config and rely on the backend at runtime.

---

- Index a geofield (latitude/longitude) into OpenSearch as a geo_point.
- Set a Search API index field's data type to `location` (Geopoint) for geospatial data.
- Enable geo-distance / bounding-box style searches backed by OpenSearch.
- Store map-marker coordinates in the search index for proximity search.
- Power "find locations near me" search using indexed geo_point data.
- Map a store/branch address's coordinates into OpenSearch for radius filtering.
- Combine full-text search with geospatial constraints on the same OpenSearch index.
- Index event or venue coordinates for location-aware search results.
- Use geofield data already on nodes as an OpenSearch-searchable geopoint.
- Make the OpenSearch backend accept the `location` data type via the support event.
- Add geospatial capability to an existing Search API OpenSearch index without custom code.
- Index real-estate listing coordinates for map-based search.
- Support sorting results by distance when querying OpenSearch (via geo_point mapping).
- Represent points of interest as geo_points in the search index.
- Feed geofield values into OpenSearch for a locator/finder feature.
- Extend a Search API OpenSearch site with location search by enabling one submodule.
- Index delivery-zone centroids as geopoints for coverage search.
- Provide geopoint data to faceted/map search UIs built on OpenSearch.
- Keep geographic and textual relevance in one OpenSearch query.
- Reuse the geofield GeoPHP parsing to normalise coordinates before indexing.
