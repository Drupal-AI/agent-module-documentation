<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Leaflet Demo adds a single admin page that renders every Leaflet map style currently available on the site — including any styles added by Leaflet More Maps — side by side, so you can eyeball whether each one loads correctly.

---

The module ships one form-based page at `/admin/config/system/leaflet-more-maps/demo` (route `leaflet_demo.demo_page`, permission `administer site configuration`). `LeafletDemoForm` takes a latitude, longitude, and zoom level (defaulting to the Old Royal Observatory, Greenwich, zoom 11), then calls core Leaflet's `leaflet_map_get_info()` to fetch every map definition currently registered on the site and renders each one, centered on the same point, via `leaflet.service`'s `leafletRenderMap()`. Because it reads whatever `leaflet_map_get_info()` returns, it automatically picks up all ~40+ styles from Leaflet More Maps (if enabled) plus any custom maps assembled on that module's settings form, or just core Leaflet's own OSM Mapnik style if Leaflet More Maps is disabled — its own `info.yml` dependency is only on `leaflet`, not `leaflet_more_maps`. It has no settings of its own, no config entity, no permissions beyond the core one on its route, and no persisted state: the lat/long/zoom form values are transient (`FormBase`, not `ConfigFormBase`) and reset to the defaults on a fresh page load. It exists purely as a smoke test — the README recommends enabling it right after configuring API keys on the Leaflet More Maps settings form, to confirm each key actually works before using a style in production. It can optionally be paired with the separate "IP Geolocation Views and Maps" (`ip_geoloc`) module to center the demo on the visitor's detected location instead of the hardcoded default.

---

- Verify a newly entered Thunderforest/HERE/Mapbox/Mapy.cz/Navionics API key actually works, right after saving it on the Leaflet More Maps settings form.
- Get a single-page visual inventory of every map style available on the site, without visiting each field/view individually.
- Confirm a custom map assembled on the Leaflet More Maps settings form renders correctly with its intended layer switcher.
- Spot-check for missing-API-key watermarks (Thunderforest) or blank tiles (HERE, Navionics) after a configuration change.
- Preview how a specific map style looks at a chosen latitude/longitude before picking it for a Geofield formatter.
- Preview how a specific map style looks at a chosen zoom level (0..18) before committing to it site-wide.
- Sanity-check the whole Leaflet map catalog after enabling or updating the leaflet_more_maps module.
- Give a site builder (not just a developer) a no-code way to browse available map styles.
- Confirm that disabling leaflet_more_maps correctly drops its styles from the catalog, leaving only core Leaflet's OSM style.
- Demonstrate the effect of a `hook_leaflet_more_maps_list_alter()` implementation by seeing the new/altered map appear on the showcase page.
- Use as a QA step after a deployment that changed map provider API keys via config import.
- Provide a quick reference page for editors deciding which map style to pick in a content type's Manage Display settings.
- Combine with IP Geolocation Views and Maps to demo every map style centered on the visitor's own location.
- Temporarily enable it during initial site setup, then disable it once the right map styles have been chosen.
- Use as a training aid to show a client the full range of map styles available before they pick one.
- Check at a glance whether Stadia/Stamen's domain-based authentication is correctly set up for the current environment (e.g. `*.ddev.site`).
