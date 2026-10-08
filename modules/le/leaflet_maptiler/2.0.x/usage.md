<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Leaflet MapTiler adds Maptiler map styles to Leaflet.

---

Leaflet MapTiler adds **MapTiler map styles/tiles to Leaflet** — so Leaflet maps can use MapTiler's
basemaps/styles. It ships a `leaflet_maptiler_token` submodule for the API token, depends on the Leaflet
module, provides its own permissions, in the Leaflet package.

Use it to style Leaflet maps with MapTiler. It is a content-display/maps feature. Security handling: MapTiler
requires an **API key/token** — the `leaflet_maptiler_token` submodule manages it; treat the token as a
**secret/config** and be aware map tiles are loaded from **MapTiler** (a third-party request from the visitor's
browser). It has no access-control role beyond its permission. Configure the MapTiler token and styles.

---

- Add MapTiler tiles to Leaflet.
- Use MapTiler basemaps/styles.
- Manage the API token (submodule).
- Depend on the Leaflet module.
- Provide its own permissions.
- Load tiles from MapTiler.
- Treat the MapTiler token as a secret.
- Note tiles are third-party requests.
- Have no access-control role beyond permission.
- Configure the token and styles.
- Handle MapTiler.
- Style maps.
- Configure Leaflet.
- Handle the tiles.
- Add map styles.
- Configure maps.
- Handle the token.
- Load map tiles.
- Set the token.
- Provide MapTiler styles.
