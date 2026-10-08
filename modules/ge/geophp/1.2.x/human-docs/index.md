# geoPHP — manual setup guide

**geoPHP** (`geophp`) is a thin Drupal wrapper around the open-source geoPHP PHP
library. Its whole job is to bundle that library and expose it to the rest of your
site as a single service, `geophp.geophp`, so other modules — most notably
**Geofield** — can read, write, and analyse geographic geometries without shipping
their own copy of the code.

You almost never install geoPHP because you want to click something. It has **no
settings page, no permissions, no blocks, and no admin screens at all**. It is a
developer/library dependency: you enable it because another contributed module
requires it, or because your own custom code needs to work with geometry data.

Through the service you can parse and convert a wide range of geographic formats —
WKT, EWKT, WKB, GeoJSON, KML, GPX, GeoRSS, GeoHash and more — into geometry objects
(points, lines, polygons, collections) and run operations on them such as
calculating a polygon's area, finding its centroid, getting a bounding box, or
serialising it back out to another format. Advanced spatial predicates (intersects,
buffer, union) additionally need the optional GEOS PHP extension, but the basic
reading, writing, and area/centroid/bounding-box math all work in pure PHP. The
module's status report entry tells you which library version is loaded and whether
GEOS is available.

This guide is written for a **human** reading through the documentation. If you want
a terse, token-cheap reference aimed at an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover the service methods and code
recipes in detail.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (usually pulled in automatically by whatever depends on it).

## How to use it

There is nothing to configure. Once the module is enabled, grab the service and hand
it a geometry string:

```php
$geophp = \Drupal::service('geophp.geophp');

// Parse WKT, then read its type, area, and centroid:
$poly = $geophp->load('POLYGON((0 0,0 10,10 10,10 0,0 0))', 'wkt');
$poly->geometryType();          // "Polygon"
$poly->area();                  // 100
$poly->centroid()->out('wkt');  // "POINT (5 5)"

// Convert a point to GeoJSON:
$geophp->load('POINT(5 5)', 'wkt')->out('json');   // {"type":"Point","coordinates":[5,5]}
```

Prefer the service over calling the underlying `\geoPHP` class statically — the
service guarantees the bundled library is loaded first. If you rely on advanced
spatial operations, check the **Reports → Status report** page (or
`\geoPHP::geosInstalled()`) to confirm the GEOS extension is present.

## Where it lives in the admin menu

Nowhere, really — geoPHP has no configuration UI. The only place it surfaces in the
admin is the **Reports → Status report** (`/admin/reports/status`), where it lists
the installed geoPHP library version and whether the optional GEOS extension is
available.
