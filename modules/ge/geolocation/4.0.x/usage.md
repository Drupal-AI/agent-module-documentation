Geolocation provides a latitude/longitude field type with map-based widgets and formatters, plus a rich plugin framework for maps, geocoding, and proximity search across Google Maps, Leaflet, and other providers.

---

Geolocation lets you store location data on any entity via a simple `geolocation` field (latitude/longitude), and edit it with map or lat/lng widgets that support geocoding an address into coordinates. Values can be displayed as raw coordinates, sexagesimal notation, token-driven text, or interactive maps through several field formatters. Its real power is a large plugin architecture: map providers (Google Maps, Leaflet, HERE, Baidu, Yandex via submodules), map features (markers, clustering, popups, controls), geocoders, tile-layer and data-layer providers, map-center strategies, and location/location-input plugins. It ships deep Views integration — a CommonMap style renders results as map markers, with proximity fields, filters, sorts, and arguments for "near me" searches. Submodules add address-field, geofield, GPX, geometry, and Search API integrations. Map providers are enabled independently (e.g. `geolocation_google_maps` needs an API key, `geolocation_leaflet` uses open tiles with no key). Everything is exportable configuration and extensible from custom code through the documented plugin types and an alter hook for map widgets. It is the standard mapping/location toolkit for content-heavy and directory-style Drupal sites.

---

- Add a latitude/longitude field to a content type to store a location.
- Let editors drop a pin on a map to set coordinates.
- Geocode a typed address into lat/lng on save.
- Display a single location as an interactive Google Map.
- Render locations on an open-source Leaflet map (no API key needed).
- Show a directory of entities as clustered markers via the Views CommonMap style.
- Build a "stores near me" proximity search with a distance filter.
- Sort Views results by distance from the visitor or a given point.
- Add a proximity contextual filter (argument) for radius searches.
- Display coordinates in sexagesimal (degrees/minutes/seconds) format.
- Output location values as text using tokens.
- Center a map automatically on the fitting bounds of all markers.
- Add marker clustering to a dense map of results.
- Add map controls, popups, or custom tile layers via map-feature plugins.
- Use HERE, Baidu, or Yandex maps in region-specific sites.
- Integrate an Address field with geocoding (geolocation_address).
- Interoperate with Geofield data (geolocation_geofield).
- Import and display GPX tracks (geolocation_gpx).
- Add proximity-aware location search through Search API (geolocation_search_api).
- Store and render geometry (polygons/lines) with geolocation_geometry.
- Show a location picker with an address-search input on a form.
- Build an event map showing all upcoming events by venue.
- Create a real-estate listing map with clustered pins and popups.
- Provide a contact page map centered on the office address.
- Write a custom MapFeature plugin to add a heatmap or drawing tools.
- Add a custom Geocoder plugin for an in-house geocoding service.
- Deploy map and field configuration between environments as config.
