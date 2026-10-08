<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Leaflet Mapbox registers Mapbox tile layers as map options for the Leaflet module, so maps rendered with Leaflet can use Mapbox's basemaps and custom styles instead of the default OpenStreetMap tiles.

---

Leaflet is the mapping library and is agnostic about where its tiles come from; its usual default is OpenStreetMap's public tile servers, which are free and explicitly **not intended for production traffic**. This module bridges Leaflet to Mapbox: on the config page at `/admin/config/services/leaflet-mapbox` (permission *administer site configuration*) an admin defines one or more maps, each with a label, an API version (3 = Studio Classic tile `code`, or 4 = Studio `mapbox://styles/...` style URL), a Mapbox access token, and a default zoom. The module implements `hook_leaflet_map_info()` (as the autowired `LeafletMapboxHooks` service) to turn each stored map into a Leaflet map definition — building the client-side tile `urlTemplate` (`//api.mapbox.com/styles/v1/{user}/{style}/tiles/{z}/{x}/{y}?access_token=…` for v4, or the `//{s}.tiles.mapbox.com/v4/…` form for v3) with the token appended. Those map ids then appear as options wherever Leaflet is configured (Leaflet Views, geofield formatters, Leaflet Map settings). Version 2.0.x is a rewrite from a single global map to a `maps` config sequence supporting **multiple** named maps; an `update_10201` hook migrates a 1.x site's flat settings into a `default` map that keeps the original `leaflet-mapbox` machine id so existing views and field displays keep working. Two non-technical points belong in any recommendation: Mapbox is **billed per map load** above a free tier, so a map on a high-traffic page is a running cost to understand before launch; and the **access token is a credential** — Mapbox tokens are public by necessity (the browser uses them), which is exactly why they should be scoped with URL restrictions at Mapbox, since an unrestricted token in page source can be used by anyone on the owner's account.

---

- Use Mapbox basemaps and custom styles with the Leaflet module.
- Style a map to match a site's design rather than the default OSM look.
- Replace OpenStreetMap's public tiles for a production map.
- Comply with OSM's tile usage policy by moving to a commercial provider.
- Configure several distinct Mapbox maps (2.0.x) and pick per display.
- Offer a light and a dark basemap as two separate map options.
- Show a branded or satellite basemap.
- Use a Mapbox Studio (API 4) style via its `mapbox://styles/...` URL.
- Use a legacy Mapbox Studio Classic (API 3) map via its tile code.
- Add a store-locator or store-finder map on a commercial tile layer.
- Back a location directory or listing's maps with Mapbox tiles.
- Support a property or real-estate listing map.
- Support a travel or tourism site's maps.
- Add terrain or outdoor styles for hiking/route content.
- Set a sensible default zoom level per map.
- Feed Mapbox tiles to a Leaflet Views map of geofield content.
- Feed Mapbox tiles to a geofield Leaflet formatter.
- Switch tile providers without changing any Leaflet configuration.
- Improve map appearance and perceived performance under traffic.
- Migrate an existing 1.x single-map setup without reconfiguring views (update hook).
- Give editors a named map option in the display-options form.
- Centralise the Mapbox access token in one admin config screen.
