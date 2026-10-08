<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mapbox_block — configuration

1. Install the **Key** module (dependency). Create a Key entity holding your
   Mapbox access token (prefer an env-backed key provider).
2. At `/admin/config/mapbox-block` (needs `administer mapbox_block`) select the
   Key via `mapbox_token_name`.
3. Add a **Mapbox Map** block (Block Layout) and configure per instance:
   container id, style (built-in or custom `mapbox://`), center lat/lng, zoom
   (0–16), and toggles (disable zoom scroll, show controls, cooperative
   gestures).
4. Add static markers in the tabledrag table (label, lat, lng, weight) — they
   render as a GeoJSON FeatureCollection.

The token is read server-side from the Key entity but handed to the browser in
`drupalSettings` because Mapbox GL runs client-side; use a public (`pk.`) token
restricted by URL in the Mapbox dashboard. Output carries cacheable metadata
from the block config and `mapbox_block.settings`.
