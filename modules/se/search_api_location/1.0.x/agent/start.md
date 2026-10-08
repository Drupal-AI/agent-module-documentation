<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Location — agent index

Adds geospatial (proximity/distance) search to **Search API**: index a geofield with a spatial
data type, then filter/sort/facet by distance. Needs a backend that supports the data types
(**Solr** is known-good; the DB backend does not). No settings form of its own — you configure
it through Search API's UI (`configure` = `search_api.overview`), on each index's Fields page.

- **Index a geofield, the two data types, backend support, distance units** →
  [configure/indexing.md](configure/indexing.md)
- **The Location Input plugin type (implement your own; existing plugins; alter hooks)** →
  [plugins/location-input.md](plugins/location-input.md)

Submodules (documented separately under `modules/`):
- `search_api_location_views` — Views filter/argument/sort for proximity search.
- `facets_map_widget` — interactive Leaflet heatmap facet (uses the `rpt` type).
- `search_api_location_geocoder` — a `geocode` Location Input that geocodes typed addresses.

Key facts:
- Search API data types: **`location`** ("Latitude/Longitude") and **`rpt`** ("Spatial
  Recursive Prefix Tree", required for facet heatmaps). Both convert a geofield WKT value to
  `"lat,lon"` via geoPHP centroid at index time (`getFallbackType()` returns NULL).
- Plugin type **`location_input`** — manager `plugin.manager.search_api_location.location_input`,
  annotation `@LocationInput`, base `LocationInputPluginBase`. Base plugins: `raw`, `geocode_map`
  (`geocode` comes from the geocoder submodule).
- Distance units km/mi via `search_api_location_get_units()`; alter with
  `hook_search_api_location_units_alter`. Alter input plugins via
  `hook_search_api_location_input_info_alter`.
- Composer libs: `itamair/geophp`. No permissions, no Drush, no config schema in the base module.
