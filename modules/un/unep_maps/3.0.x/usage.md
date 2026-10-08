<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UNEP Maps renders Views results on a Mapbox GL map. It adds a `mapbox_map` Views style plugin that can plot geofield points as pins, highlight countries by ISO3 code, or draw area polygons (converted from WKT via geoPHP to GeoJSON), with custom or UN ("carto tile") basemaps.
---
The style plugin (`MapboxMapStyle`) builds an options form (basemap/tile type, render items, colours, popup sources, country-click links, display/zoom/projection options) and passes the assembled configuration — including the Mapbox access token from `unep_maps.settings` — into `drupalSettings` for the front-end library `unep_maps/unep_map`. Marker/popup/country/area data is produced by `UnepMapsDataService`, which renders Views fields for popups and resolves click-through links. A settings form at `/admin/config/system/unep_maps` stores the Mapbox token and default style URL. The module ships under machine name `unep_maps` (formerly `edw_maps`, still present as an OLD info file).

Security posture: two routes. The settings form (`unep_maps.admin_settings_form`) requires `administer modules` (admin). The second route, `unep_maps.carto_tile_disclaimer` (`/unep-maps/carto-tile-disclaimer`), is gated by **`access content`** (effectively public) — but its controller `UnepMapsController::mapDisclaimer()` only returns a hard-coded static HTML paragraph of UN boundary/naming disclaimer text; it takes no request input, performs no fetch and is not a data proxy, so the permissive access is benign. The Mapbox token is public-client by nature (exposed to the browser in `drupalSettings`), which is expected for Mapbox GL usage — scope/restrict the token in the Mapbox account. Popup content is rendered from Views fields through the renderer.
---
- Add a Mapbox map display to a View of geolocated content.
- Plot geofield points as interactive pins.
- Highlight countries on the map by ISO3 code.
- Draw area polygons from WKT geofield data.
- Configure the Mapbox access token at /admin/config/system/unep_maps.
- Set a default Mapbox style URL for all maps.
- Use a custom Mapbox style per view display.
- Use UN "carto tile" basemaps for country highlighting.
- Render a clear/boundary GeoJSON base map.
- Attach popups sourced from a chosen Views field.
- Show hover popups on pins.
- Set country fill and hover colours.
- Set area polygon fill and hover colours.
- Make countries click-through to an entity link.
- Open country links in a new tab or same window.
- Cluster dense pin markers.
- Control initial center, zoom, pitch and projection.
- Toggle scroll-zoom and world-copy wrapping.
- Show the UN boundary disclaimer modal on the map.
- Alter pin/country/area data via `hook_unep_maps_*_data` hooks.
- Restrict/scope the public Mapbox token in the Mapbox account.
