<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Geolocation - Tian Maps registers the Chinese Tianditu (天地图) map service as a provider plugin for the Geolocation module, so geolocation fields and views can render maps using Tianditu tiles.

---

The module is a thin provider on top of `geolocation`. It supplies a `MapProvider` plugin (`tian`), plus a marker-info-window layer feature and a zoom-control map feature, and a settings form at `/admin/config/services/geolocation/tian_maps` (menu: Configuration → Web services). You enter your Tianditu App ID ("key") there; it is saved to `geolocation_tian.settings` config. At render time the provider builds the Tianditu JS API URL — `https://api.tianditu.gov.cn/api?v=4.0&tk=<key>&callback=...` — and attaches it to `drupalSettings` so the browser loads the Tianditu library client-side; per-map settings (zoom 3–19, width, height) come from each field/view's map settings form. `hook_requirements()` warns on the status report if no key is configured.

Security/operational notes: all configuration is gated by the Geolocation `configure geolocation` permission; the module has no anonymous or mutating endpoints, no server-side outbound HTTP, and no request-supplied value drives any URL (no SSRF surface). The API base is hardcoded to HTTPS. The Tianditu App ID is a client-side JS key: it is stored in plaintext config and emitted into the page's `drupalSettings`/script URL (inherent to a browser map key, not a server secret), so treat it as public and restrict it by referrer/domain in the Tianditu console rather than expecting it to stay secret. Setup: enable `geolocation` + `geolocation_tian`, obtain a key at console.tianditu.gov.cn/api/key, save it on the settings form, then choose "Tian Maps" as the map provider on a geolocation field formatter or view.

---
- Add Tianditu (Tian) Maps as a provider option in Geolocation
- Configure the Tianditu App ID at `/admin/config/services/geolocation/tian_maps`
- Render a geolocation field on a map using Tianditu tiles
- Use the Tian provider as a Views map style/format
- Set the default zoom level (3–19) for a Tian map
- Set map width and height (px or %) per field/view
- Show a marker info window via the Tian info-window layer feature
- Add a navigation/zoom control to a Tian map
- Position the zoom control (top-left/right, bottom-left/right)
- Serve maps for China-focused sites where Google/Mapbox are unavailable
- Check the status report for a missing Tianditu key warning
- Swap an existing geolocation map from another provider to Tian
- Restrict the client-side key by domain in the Tianditu console
- Uninstall cleanly (settings config is deleted on uninstall)
- Combine Tian maps with other Geolocation field types and widgets
- Display multiple markers from a view on a single Tian map
