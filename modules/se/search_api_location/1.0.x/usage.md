<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Location lets Search API index geofield location values and then filter, sort and facet on them by proximity/distance, provided the search backend (e.g. Solr) supports spatial data types.

---

The module registers two Search API data types — `location` ("Latitude/Longitude") and `rpt` ("Spatial Recursive Prefix Tree") — that convert a geofield's WKT value to a `lat,lon` string (via geoPHP's centroid) when indexing. You add a geofield to a Search API index's fields and choose `location` (for views distance filtering/sorting) or `rpt` (needed for facet heatmaps). It also defines a **Location Input** plugin type (`@LocationInput`, manager `plugin.manager.search_api_location.location_input`) describing how an end user enters the "search from here" point; the base module ships `raw` (type "lat,lon") and `geocode_map` (pick on a Google map), and the `search_api_location_geocoder` submodule adds `geocode` (geocode a typed address). Distance searching is kilometre-based with km/mi units (`search_api_location_get_units()`), alterable via `hook_search_api_location_units_alter`, and the plugin list via `hook_search_api_location_input_info_alter`. Three submodules build on it: `search_api_location_views` (Views filter/argument/sort for proximity), `facets_map_widget` (an interactive Leaflet heatmap facet using the `rpt` type), and `search_api_location_geocoder` (address geocoding input). The backend must support these data types — Search API Solr is the known-good backend; the default database backend does not do spatial search. Configuration is done through Search API's own UI (`configure` = `search_api.overview`), on each index's Fields page.

---

- Build a "stores near me" search that ranks results by distance from the user.
- Index a geofield of event venues and filter events within 10 km of a point.
- Sort a Search API view of listings by proximity to a searched location.
- Add a distance-range dropdown (5/10/25 km) to an exposed Views filter.
- Let users type raw `lat,lon` coordinates as the search origin (`raw` input plugin).
- Let users pick the search origin on a map (`geocode_map` input plugin).
- Let users type a street address that gets geocoded to coordinates (`geocode` input, geocoder submodule).
- Show an interactive Leaflet heatmap facet that clusters results geographically (facets_map_widget, `rpt` type).
- Index the same geofield twice: once as `location` for Views, once as `rpt` for heatmap facets.
- Switch between kilometres and miles for the distance UI via the units setting.
- Add a custom distance unit (e.g. nautical miles) with `hook_search_api_location_units_alter`.
- Implement a custom Location Input plugin (e.g. "use browser geolocation") against the plugin type.
- Alter an existing location input plugin's label/description with `hook_search_api_location_input_info_alter`.
- Provide proximity search on a Solr-backed Search API index.
- Return the distance of each result as a pseudo-field for display in a view.
- Restrict a faceted search to a geographic area drawn on a map.
- Geocode addresses using an ordered list of geocoder providers (first valid wins).
- Convert stored WKT/point geofield values to `lat,lon` automatically at index time via geoPHP centroid.
- Combine location filtering with other Search API facets and keyword search.
- Offer multiple radius options where "-" ignores distance for filtering but still computes it for sorting.
- Power a real-estate or job-board "search within X of a place" feature.
- Add spatial search to an existing Solr index without writing backend code.
- Reuse the parsed coordinate string (`getParsedInput()`) from a Location Input plugin in custom code.
