# API — services & hooks

## Services (`geofield_map.services.yml`)

- `geofield_map.google_maps` (`Drupal\geofield_map\Services\GoogleMapsService`) — resolves
  the Google Maps API key (plain config or Key entity) and builds the Google Maps JS load
  URL, honoring `gmap_api_localization` (default/china). Optional `key.repository` dependency.
- `geofield_map.marker_icon` (`Drupal\geofield_map\Services\MarkerIconService`) — manages
  the marker-icon files/selection used by the theming system (storage location, extensions,
  file-size limits from `geofield_map.settings`).
- `geofield_map.geocoder` (`Drupal\geofield_map\Services\GeocoderService`) — geocoding helper.
- `plugin.manager.geofield_map.themer` — MapThemer plugin manager (see plugins/plugins.md).
- `plugin.manager.leaflet_tile_layer_plugin` — Leaflet tile-layer plugin manager.

Each service also has an autowire alias on its class FQN.

## Alter hooks (`geofield_map.api.php`)

- `hook_geofield_map_latlon_element_alter(array &$map_settings, array &$complete_form, array &$form_state_values)`
  — alter settings passed into the Geofield Map input **widget** element.
- `hook_geofield_map_formatter_feature_alter(array &$feature, GeofieldItem $item, ContentEntityBase $entity)`
  — adjust a single marker/feature produced by the **formatter**.
- `hook_geofield_map_googlemap_formatter_alter(array &$map_settings, FieldItemListInterface &$items)`
  — add/alter the JS map settings of the Google Maps **formatter**.
- `hook_geofield_map_views_feature_alter(array &$feature, ResultRow $row, ?RowPluginBase $rowPlugin = NULL)`
  — adjust a marker/feature produced by the **Views style**.
- `hook_geofield_map_googlemap_view_style_alter(array &$map_settings, GeofieldGoogleMapViewStyle &$view_style)`
  — add/alter the JS map settings of the Google Maps **Views style**.

## Plugin ids reference

- Field widget: `geofield_map`
- Field formatter: `geofield_google_map`
- Views style: `geofield_google_map`
- Block: `geofield_map_legend`
- Render element: `Drupal\geofield_map\Element\GeofieldMap`
