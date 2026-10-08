<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Styled Google Map renders a [Geofield](https://www.drupal.org/project/geofield) value as a fully styled, interactive Google Map, either as a single-entity field formatter or as a multi-location Views style. Map appearance (JSON style, pins, zoom, popups, clustering, directions) is configured entirely through the field-display / Views UI.

---

The module provides a Geofield field formatter (`styled_google_map_default`) and a Views style plugin (`styled_google_map`, plus a Views area `Control` handler) that turn latitude/longitude data into a Google Maps JavaScript embed. On the field formatter you set the map width/height, a raw Google Maps JSON style string, a custom pin image (with width/height), gesture handling, zoom (default/min/max), map controls (zoom, fullscreen, streetview, maptype, scale, rotate, draggable), optional turn-by-turn directions, and an info-bubble popup (rendered from a chosen view mode or text field, with extensive styling — border, arrow, padding, colours). The Views style adds multi-marker maps with the same popup options plus marker clustering (js-marker-clusterer), spiderfying overlapping markers (OverlappingMarkerSpiderfier), heatmaps (the Google `visualization` library) and a configurable map center. A single global settings form (`/admin/config/services/styled_google_map`, config object `styled_google_map.settings`) holds the Google Maps API key or Maps-for-Work client ID plus which optional Google libraries (drawing, geometry, localContext, places) to load. Output is themeable via the `styled_google_map` and `styled_google_map_directions` theme hooks, and `hook_styled_google_map_views_style_alter()` lets code mutate markers and settings before render. Two bundled submodules — `styled_google_map_demo` (a Real Estate demo entity type) and `styled_google_map_data` (demo content + example views) — showcase every feature.

---

- Show a single node's location (a Geofield) as a styled Google Map on its full display.
- Apply a custom Google Maps JSON style (Snazzy Maps / Google style wizard) to brand a map.
- Replace the default marker with a custom pin image sized to your artwork.
- Add a click/hover info bubble that renders a node's teaser view mode as the popup.
- Build a multi-location store-locator map from a View of address content.
- Cluster hundreds of markers with js-marker-clusterer so the map stays readable when zoomed out.
- Spiderfy markers that share the same coordinates using OverlappingMarkerSpiderfier.
- Render a heatmap layer from a View of geolocated points via the Google `visualization` library.
- Center a Views map on a fixed coordinate instead of auto-fitting the bounds.
- Set default/min/max zoom to constrain how far users can zoom a map in or out.
- Configure gesture handling (cooperative/greedy/none) so scroll-zoom behaves well inside long pages.
- Toggle individual map controls: zoom, fullscreen, streetview, maptype, scale, rotate, draggable.
- Offer turn-by-turn directions from the visitor's location to a mapped point.
- Store the Google Maps API key once (`styled_google_map.settings`) and reuse it across all maps.
- Switch authentication to Google Maps API for Work using a Client ID instead of an API key.
- Load extra Google Maps libraries (drawing, geometry, localContext, places) globally when needed.
- Place several independent map blocks on one page via Views block displays.
- Style the info bubble (border colour/width/radius, arrow style/size, padding, background, min/max size).
- Add a Views exposed-filter control positioned on the map (as the demo data submodule does).
- Alter markers or map settings programmatically in `hook_styled_google_map_views_style_alter()`.
- Override the `styled_google_map` Twig template to customise the map container markup.
- Provide a mobile-specific draggable setting so touch dragging can differ from desktop.
- Present a taxonomy-icon-per-type map (e.g. property types) as shown by the demo submodule.
- Prototype quickly by enabling `styled_google_map_data` to load ready-made example maps at /heatmap, /cluster-map, etc.
