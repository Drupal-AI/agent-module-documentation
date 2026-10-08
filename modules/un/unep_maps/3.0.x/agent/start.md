<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UNEP Maps (unep_maps) — agent index

**Views style plugin rendering results on a Mapbox GL map as pins, country highlights or WKT area polygons, with UN tiles and a boundary disclaimer.**

- **Version:** 3.0.x (project `unep_maps`; legacy `edw_maps.info.yml` also present)
- **Core:** ^10.3 || ^11
- **Dependencies:** views, geofield (uses geoPHP + Mapbox GL JS)
- **Views style:** `mapbox_map` → `MapboxMapStyle`; data via `unep_maps.utils` (`UnepMapsDataService`)
- **Configure:** `unep_maps.admin_settings_form` → `/admin/config/system/unep_maps` (perm `administer modules`) — stores Mapbox `token`, `default_style_url`
- **Routes:** settings form (`administer modules`); `unep_maps.carto_tile_disclaimer` `/unep-maps/carto-tile-disclaimer` (**`access content`**)
- **Alter hooks:** `unep_maps_pin_data`, `unep_maps_country_data`, `unep_maps_area_data`

**Security:** The `access content` route (`UnepMapsController::mapDisclaimer`, src/Controller/UnepMapsController.php:384) returns only **static hard-coded** UN boundary disclaimer HTML — no request input, no fetch, no data proxy — so the public access is benign. Settings form is admin-gated. Mapbox `token` is emitted to `drupalSettings` (expected public-client token — scope it in Mapbox).

See [configure/mapbox.md](configure/mapbox.md) and [plugins/mapbox-style.md](plugins/mapbox-style.md)
