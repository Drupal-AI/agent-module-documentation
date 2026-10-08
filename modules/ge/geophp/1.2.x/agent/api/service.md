<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `geophp.geophp` service & geoPHP API

## The Drupal service

```php
$geophp = \Drupal::service('geophp.geophp');   // Drupal\geophp\GeoPHPWrapper
```

`GeoPHPWrapper` (implements `Drupal\geophp\GeoPHPInterface`) has exactly three methods; its
constructor `require_once`s the module's bundled `geoPHP/geoPHP.inc`:

| Method | Delegates to | Purpose |
|---|---|---|
| `version()` | `\geoPHP::version()` | Installed library version (bundled reports `"1.1"`). |
| `load(...$args)` | `\geoPHP::load(...)` | Parse input into a geometry object. |
| `getAdapterMap()` | `\geoPHP::getAdapterMap()` | The format-id → adapter-class map. |

In services/DI, inject `@geophp.geophp`. There is a procedural fallback `geophp_load()` that
just ensures the library is loaded (returns the include path or FALSE).

## `load($data, $type = NULL)`

- `$data` — the geometry source (a WKT/GeoJSON/… string, or an array of geometries).
- `$type` — the format id (`'wkt'`, `'json'`, `'wkb'`, `'kml'`, `'gpx'`, `'georss'`,
  `'geohash'`, `'ewkt'`, …). If omitted, geoPHP auto-detects the format.
- Returns a geometry object (`Point`, `LineString`, `Polygon`, `MultiPolygon`,
  `GeometryCollection`, …), or an existing `Geometry` unchanged.

## Geometry object API (from the geoPHP library)

Common methods on the returned object:

- `geometryType()` → e.g. `"Point"`, `"Polygon"`.
- `out($format)` → serialise, e.g. `->out('json')` (GeoJSON), `->out('wkt')`, `->out('wkb')`,
  `->out('kml')`.
- `area()`, `length()`, `centroid()` (returns a `Point`), `getBBox()` (assoc array
  maxy/miny/maxx/minx), `envelope()`, `getPoints()`, `getX()/getY()` (points).
- Spatial predicates/operations (`intersects`, `buffer`, `union`, …) require the **GEOS** PHP
  extension; the basic reader/writer + area/centroid/bbox work in pure PHP.

## Recipes (verified against the live service)

```php
$geophp = \Drupal::service('geophp.geophp');

// WKT -> geometry, area & type:
$poly = $geophp->load('POLYGON((0 0,0 10,10 10,10 0,0 0))', 'wkt');
$poly->geometryType();   // "Polygon"
$poly->area();           // 100
$poly->centroid()->out('wkt');   // "POINT (5 5)"

// WKT -> GeoJSON:
$point = $geophp->load('POINT(5 5)', 'wkt');
$point->out('json');     // {"type":"Point","coordinates":[5,5]}

// Auto-detect format (no $type):
$g = $geophp->load('{"type":"Point","coordinates":[1,2]}');
```

## Notes for an agent

- No configuration exists; behaviour is entirely the geoPHP library API.
- Prefer the service over calling `\geoPHP` statically so the library is guaranteed loaded.
- GEOS is optional; check the Status report (`hook_requirements`) or
  `\geoPHP::geosInstalled()` before relying on advanced spatial operations.
- This module is usually a **dependency** of Geofield / other geo modules rather than something
  you configure directly.
