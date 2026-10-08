<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alimap (alimap) — agent index

**Integrates the AMap (Gaode / 高德地图) JavaScript map for displaying coordinate points and polygons.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Configure route:** `alimap.settings` → `/admin/config/services/alimap` (permission `administer site configuration`)
- **Library:** external AMap loader `//webapi.amap.com/loader.js`
- **Key code:** `src/AlimapTrait.php` — shared settings form (dimensions, style, controls) + `getAlimapApiKey()`/`getAlimapSecurityKey()` config accessors.
- Provides field types `alimap_field` (points) and `alimap_polygon_field` (lines/polygons/circles) per README.

**Security:** single admin settings route gated by `administer site configuration`; no anonymous or mutating endpoints. AMap API key + security (jscode) key live in `alimap.settings` config and are surfaced to front-end JS — scope the security key to the site domain in the AMap console.

See [configure/alimap.md](configure/alimap.md)