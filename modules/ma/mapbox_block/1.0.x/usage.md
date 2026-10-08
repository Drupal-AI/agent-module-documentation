<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mapbox Block provides a configurable Drupal block that renders an interactive Mapbox GL JS map, with per-block style, center, zoom, behaviour options and a set of draggable static markers.
---
Each block instance is configured in its block form: container id, a built-in Mapbox style (streets, outdoors, satellite, navigation, …) or a custom `mapbox://` style, center latitude/longitude, zoom, and toggles for disable-zoom-scroll, show-controls and cooperative gestures. Static markers are managed in a tabledrag table (label + lat/lng + weight) and emitted as a GeoJSON FeatureCollection. The `build()` method attaches the `mapbox_block/mapbox_block` library and passes options + markers through `drupalSettings`, applying cacheable metadata from both the block config and the module settings.

The Mapbox access token is not stored in block config: the module depends on the **Key** module and retrieves the token by the key name saved in `mapbox_block.settings` (`mapbox_token_name`) via `key.repository`, so the secret lives in a Key entity rather than plaintext config. The settings form at `/admin/config/mapbox-block` is gated by the `administer mapbox_block` permission. The token is a Mapbox public/pk access token exposed to the browser via drupalSettings (expected for client-side Mapbox GL) — scope/restrict it in the Mapbox dashboard accordingly. No external calls happen server-side; the map is rendered client-side.
---
- Add a Mapbox Map block to a region via Block Layout.
- Store the Mapbox access token in a Key entity.
- Select the Key that holds the token at /admin/config/mapbox-block.
- Choose a built-in Mapbox style (streets, satellite, etc.).
- Use a custom `mapbox://` studio style.
- Set the map center latitude/longitude.
- Set the default zoom level (0–16).
- Add draggable static markers with label + coordinates.
- Reorder markers with tabledrag weights.
- Render markers as a GeoJSON FeatureCollection.
- Disable scroll-to-zoom on the map.
- Show or hide navigation controls.
- Enable cooperative gestures for touch devices.
- Give the map container a custom DOM id.
- Localise the map to the current content language.
- Place multiple independently-configured maps on a page.
- Cache map output with block + settings cacheability.
- Restrict map configuration to the `administer mapbox_block` permission.
- Show a store locator or event location map.
- Embed a themed satellite/navigation map in a landing page.
