Geolocation - Leaflet adds the open-source Leaflet library as a map provider for the Geolocation module, using open tile layers and Nominatim geocoding with no API key required.

---

This submodule registers a Leaflet map provider so geolocation fields, widgets, formatters, and Views maps can render with Leaflet and open tile layers (e.g. OpenStreetMap) instead of a commercial API. It ships a set of tile-layer providers, Leaflet-specific map and layer features, and a Leaflet field option. Geocoding is available via Nominatim (OpenStreetMap's geocoder), configurable at `/admin/config/services/geolocation/nominatim`, including road-first and country formatting variants. Because it uses open tiles, it needs no billing account or API key, which makes it the go-to provider for privacy-conscious or budget-limited sites (subject to the tile provider's usage policy). Requires the base `geolocation` module; a demo submodule provides examples.

---

- Render geolocation maps with Leaflet and OpenStreetMap tiles, no API key.
- Offer an interactive map widget for editing coordinates via Leaflet.
- Geocode addresses using the Nominatim (OSM) geocoder.
- Configure Nominatim geocoding options (road-first, country formatting).
- Choose among multiple open tile-layer providers for the base map.
- Show a Views CommonMap of results on a Leaflet map.
- Cluster dense markers on a Leaflet map.
- Center a Leaflet map on the fitting bounds of all markers.
- Add Leaflet-specific map features (controls, popups) to a map.
- Build a store/venue locator without commercial map costs.
- Provide a privacy-friendly map that avoids Google tracking.
- Display a single location as a Leaflet map on a node.
- Add a custom tile layer (e.g. a themed OSM style) via a tile-layer provider.
- Power a proximity "near me" search rendered on a Leaflet map.
- Use Leaflet as the default provider across the whole site.
