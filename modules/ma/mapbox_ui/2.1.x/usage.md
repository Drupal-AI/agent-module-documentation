<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MapBox UI provides a placeable Mapbox block that renders an interactive Mapbox GL map, configured entirely from a single admin settings form.

---

Embedding a Mapbox map usually means writing JavaScript and wiring a token, style, center, and marker by hand. This module turns that into a block: an admin enters a Mapbox access token, a style, center coordinates, a marker position with popup text, a zoom level, and whether to show navigation controls, and the **Mapbox block** renders the map wherever it is placed. The block's `build()` reads `mapbox_ui.settings`, hands the values to `drupalSettings`, attaches the `mapbox_ui/mapbox_ui` library (Mapbox GL JS/CSS from the `//api.mapbox.com` CDN plus the module's `mapboxscript.js`), and renders the `mapbox-ui-block` template.

The configuration form at `/admin/config/mapbox_ui/config` is gated by `administer site configuration`; the block itself is visible to anyone with `access content`. The Mapbox access token is a **public** client-side token (`pk.…`) that is exposed in page JavaScript by design — that is how Mapbox GL works in the browser, so it is expected, not a leaked secret; still, use a URL-restricted public token and never a secret (`sk.`) token here. Two rough edges to be aware of: `submitForm()` saves the navigation-control checkbox to a mis-keyed config name (`'  navigationControl'` with leading spaces), so that toggle may not persist as expected; and the README lists an outdated config path (`/admin/config/mapbox/config`) while the real route is `/admin/config/mapbox_ui/config`.

Setup: create a Mapbox public token and style, enter them plus center/marker/zoom on the settings form, then place the Mapbox block in a region via Block layout.

---

- Show an interactive Mapbox map in any block region
- Configure the map without writing JavaScript
- Set the initial map center latitude/longitude
- Drop a marker at a chosen coordinate
- Add popup text shown on the marker
- Set the initial zoom level
- Toggle Mapbox navigation (zoom/rotate) controls
- Choose the Mapbox style (streets, satellite, custom) by style URL/id
- Place the map on a landing page, contact page, or footer
- Use a URL-restricted public Mapbox token for the embed
- Point the block at a custom Mapbox Studio style
- Display an office/branch location to visitors
- Reuse one site-wide map configuration across placements
- Restrict map configuration to site administrators
- Load Mapbox GL from the Mapbox CDN via the attached library
- Render the map for all users with `access content`
