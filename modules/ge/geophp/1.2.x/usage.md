<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
geoPHP is a thin Drupal wrapper around the open-source geoPHP PHP library, exposing it as the service `geophp.geophp` so other modules (notably Geofield) can read, write and analyse geometries without bundling their own copy.

---

The module ships the geoPHP library (in its `geoPHP/` folder) and provides one service,
`geophp.geophp` (`Drupal\geophp\GeoPHPWrapper` implementing `GeoPHPInterface`), whose
constructor `require_once`s the bundled `geoPHP/geoPHP.inc` and which exposes three methods:
`version()`, `load(...)` (delegates to `\geoPHP::load()`), and `getAdapterMap()`. Through the
underlying `\geoPHP` class you can parse and serialise a wide range of formats — WKT, EWKT, WKB,
EWKB, GeoJSON, KML, GPX, GeoRSS, GeoHash, Google-geocode — into Simple-Feature geometry objects
(`Point`, `LineString`, `Polygon`, `MultiPoint`, `GeometryCollection`, …) and call geometry
operations such as `area()`, `centroid()`, `getBBox()`, `length()`, `envelope()`, and
`out($format)` to convert between formats. It has **no** configuration, permissions, routes,
plugins, or Drush commands — it is purely an API/library dependency. A procedural helper
`geophp_load()` and a `hook_requirements()` implementation load the library and report its
version plus whether the optional GEOS PHP extension is available (GEOS is not required but
speeds up operations). This project is the modern successor used by Geofield and other geospatial
contrib modules; install it only if another module requires it or you need geometry operations in
custom code.

---

- Parse a WKT string (`POINT(5 5)`, `POLYGON(...)`) into a geometry object in custom code.
- Convert a geometry between formats, e.g. WKT → GeoJSON via `->out('json')`.
- Compute the area of a polygon with `->area()`.
- Find a geometry's centroid with `->centroid()`.
- Get a bounding box / envelope for a geometry (`->getBBox()`, `->envelope()`).
- Read GeoJSON from an API response into geometry objects for processing.
- Serialise geometries to WKB for storage in a spatial database column.
- Import KML or GPX track data and work with it as geometry objects.
- Encode/decode GeoHash strings.
- Provide the geometry backend that Geofield relies on.
- Measure the length of a LineString.
- Merge multiple geometries into a GeometryCollection.
- Detect a geometry's type (`->geometryType()`) before processing.
- Reproject or transform coordinates in a custom import pipeline.
- Validate that a user-supplied WKT/GeoJSON string parses correctly.
- Build a MultiPolygon from several polygons programmatically.
- Convert between GeoRSS and GeoJSON for a feed integration.
- Compute distances/relationships when the GEOS extension is installed.
- Expose the shared geoPHP library to several modules without duplicate copies.
- Check the installed geoPHP library version via the service or the status report.
- Report GEOS availability on the Status report for performance tuning.
- Generate a geometry's WKT to display coordinates to an editor.
- Back a custom REST endpoint that returns GeoJSON for map rendering.
- Support a migration that transforms address/coordinate data into geometries.
