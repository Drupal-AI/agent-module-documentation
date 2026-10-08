# Geolocation submodules

Shipped under `geolocation/modules/`. All depend on `geolocation:geolocation`. Enable the map
provider(s) and integrations you need.

## Map providers
- **geolocation_google_maps** — Google Maps API integration. Has config page
  `geolocation_google_maps.settings` for the API key. Provides Google map provider, geocoders,
  and country formatting. (Documented separately.)
- **geolocation_leaflet** — Leaflet (open-source) map provider using open tile layers; no API
  key required. Includes Nominatim geocoding. (Documented separately.)
- **geolocation_here** — HERE Maps provider.
- **geolocation_baidu** — Baidu Maps provider (China).
- **geolocation_yandex** — Yandex Maps provider (Russia/CIS).

## Geocoders / data
- **geolocation_geocodio** — Geocodio geocoding backend (needs `geocodio/geocodio-library-php`).
- **geolocation_address** — integrate the `address` field with geolocation/geocoding.
- **geolocation_geofield** — use `geofield` data in the CommonMap Views style.
- **geolocation_geometry** — geometry-based fields (polygons/lines) and integration.
- **geolocation_gpx** — GPX file field type/widget/formatter (needs `sibyx/phpgpx`).

## Search
- **geolocation_search_api** — use Search API fields in the geolocation map Views style for
  proximity/location search at scale.

## Demo (skip in production)
- **geolocation_demo** — example views and pages; not for production.
