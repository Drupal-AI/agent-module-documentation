# Geofield services & field value API

## Services
- `geofield.geophp` (`Drupal\geofield\GeoPHP\GeoPHPInterface`) — wraps the GeoPHP library.
  `->load($data, $type = NULL): ?\Geometry` parses WKT/WKB/GeoJSON/etc into a geometry;
  `->version()`, `->getAdapterMap()`.
- `geofield.wkt_generator` (`Drupal\geofield\WktGeneratorInterface`) — build/generate WKT:
  `wktBuildPoint($point)`, `wktBuildLinestring($points)`, `wktBuildPolygon($points)`,
  `wktBuildMultipolygon($rings)`, plus random `wktGeneratePoint()`, `wktGenerateLinestring()`,
  `wktGeneratePolygon()`, `wktGenerateMultipoint()`, `wktGenerateGeometry()`, etc.
- `Drupal\geofield\DmsConverter` (static): `dmsToDecimal(DmsPoint $point)` and
  `decimalToDms($lon, $lat)` convert between DMS and decimal degrees.
- `plugin.manager.geofield_backend`, `plugin.manager.geofield_proximity_source` — plugin
  managers (see [plugins/plugins.md](../plugins/plugins.md)).

```php
$geom = \Drupal::service('geofield.geophp')->load('POINT (11.25 43.77)', 'wkt');
$lat = $geom->getCentroid()->getY();

$wkt = \Drupal::service('geofield.wkt_generator')->wktBuildPoint([11.25, 43.77]);
$entity->set('field_location', $wkt); // stored, other columns are derived on save
```

## Reading a field value
Each delta exposes the derived properties directly:
```php
$item = $entity->get('field_location')->first();
$item->value;    // WKT geometry
$item->lat;      // centroid latitude
$item->lon;      // centroid longitude
$item->geo_type; // 'point' | 'linestring' | 'polygon' | ...
$item->geohash;  // geohash of the geometry
$item->top; $item->bottom; $item->left; $item->right; // bounding box
```
JSON:API: the `GeofieldGeoJsonEnhancer` FieldEnhancer emits values as GeoJSON.
Validation: the `GeoConstraint` constraint validates submitted geometry strings.
