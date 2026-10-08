<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `mapbox_map` Views style

## Adding a map
Create a View, set **Format → UNEP Mapbox Map** (`MapboxMapStyle`). It renders even when empty (`evenEmpty()` = TRUE).

## Options (buildOptionsForm)
- **tile_options.map_type** — `custom` (needs a `style_url` or configured default), `carto_tile` (UN tiles; country highlight only), `clear_map` (boundary GeoJSON).
- **rendering_options.render_items** — `pin`, `country`, `area` (+ source fields and colours). Carto tile supports only country highlight (validated).
- **popup_options** — pin/country/area popup source fields (+ pin hover).
- **country_click** — link source field and `_blank`/`_self` mode.
- **display_options** — center, zoom, maxZoom, pitch, projection, scroll-zoom, world copies, clusters, hover popups, disclaimer modal, navigation control position.

## Data building — `UnepMapsDataService` (service `unep_maps.utils`)
- `getPinData()` — geofield points → `[lon,lat]` + rendered popup/hover.
- `getCountryData()` — ISO3 string field → colour + popup + click link.
- `getAreaData()` — WKT polygon → GeoJSON FeatureCollection via `geoPHP::load(...,'wkt')`.
- `getClearMapSource()` — module-hosted `country_polygon.json`.
Popups render Views fields through the core renderer. Results are exposed to JS in `drupalSettings.unep_map`.

## Alter hooks
`unep_maps_pin_data`, `unep_maps_country_data`, `unep_maps_area_data` let other modules mutate the data before it reaches the map.
