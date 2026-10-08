# leaflet.service

Service **`leaflet.service`** (`Drupal\leaflet\LeafletService`, also autowired by class name).
Build and render maps from code, outside the field formatter.

```php
$leaflet = \Drupal::service('leaflet.service');

// Get a named map definition (from hook_leaflet_map_info()); omit $map for all.
$map = $leaflet->leafletMapGetInfo('OSM Mapnik');

// Turn Geofield items into Leaflet features (points/lines/polygons).
$features = $leaflet->leafletProcessGeofield($geofield_items);

// Render a full map render array.
$build = $leaflet->leafletRenderMap($map, $features, '400px');
```

Other helpers: `setFeatureIconSizesIfEmptyOrInvalid(&$feature)`,
`setGeocoderControlSettings(&$settings, &$libraries)`, `generateAbsoluteString($uri)`,
`fileExists($url)`, `leafletIconDocumentationLink()`.

The procedural `leaflet_map_get_info($map)` in `leaflet.module` is the cached front-end to the
map-definition system (invokes + alters `hook_leaflet_map_info`), cached in the `leaflet` cache
bin. `leafletRenderMap()` returns a render array using the `leaflet_map` theme hook
(see [../theming/theme.md](../theming/theme.md)).
