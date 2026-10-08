<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# geoPHP — agent index

Wraps the geoPHP geometry library as the Drupal service **`geophp.geophp`**. Pure API/library
module: no config (`configure: null`), no permissions, no routes, no plugins, no Drush. Other
modules (e.g. Geofield) depend on it for geometry parsing/analysis.

- **The service, its methods, the geoPHP library API (formats, geometry operations), and code
  recipes** → [api/service.md](api/service.md)

Key facts:
- Service id: `geophp.geophp` → `Drupal\geophp\GeoPHPWrapper` (`GeoPHPInterface`): `version()`,
  `load($data, $type = NULL, …)`, `getAdapterMap()`.
- `load()` delegates to `\geoPHP::load()`; the returned geometry object has the full geoPHP API
  (`area()`, `centroid()`, `getBBox()`, `out($format)`, `geometryType()`, …).
- Supported formats: WKT, EWKT, WKB, EWKB, GeoJSON, KML, GPX, GeoRSS, GeoHash, GoogleGeocode.
- `hook_requirements()` shows the library version and whether the optional GEOS extension is
  present (GEOS is not required, only a performance boost). Bundled library version reports `1.1`.
