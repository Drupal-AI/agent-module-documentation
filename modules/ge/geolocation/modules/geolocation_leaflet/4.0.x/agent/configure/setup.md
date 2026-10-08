# Leaflet setup

## Enable & select
Enable `geolocation_leaflet` (requires `geolocation`). No global config is required — "Leaflet"
becomes a selectable **map provider** in geolocation field widget/formatter settings and in the
Views CommonMap style. It uses open tile layers, so no API key or billing is needed (respect the
tile provider's usage policy).

## Tile layers
Provided by `src/…/LeafletTileLayerProviders.php` and
`config/schema/geolocation_leaflet.map_features.tile_layer_providers.schema.yml`. Pick the base
tile layer (e.g. OpenStreetMap) in the map settings; add custom tile-layer providers via a
`TileLayerProvider` plugin.

## Nominatim geocoding
Form `NominatimGeocodingSettings` at `/admin/config/services/geolocation/nominatim`
(route `geolocation_leaflet.nominatim_settings`, config
`geolocation_leaflet.nominatim_settings`). Configures the OpenStreetMap Nominatim geocoder used
to turn addresses into coordinates, plus road-first and country-formatting variants
(`NominatimRoadFirstFormattingBase`, `NominatimCountryFormattingBase`).

## What it provides
- **MapProvider**: Leaflet (`src/…/Leaflet.php`).
- Leaflet map/layer features and a Leaflet field option
  (`config/schema/geolocation_leaflet.*.schema.yml`).
- `geolocation_leaflet_demo` — examples (skip in production).
