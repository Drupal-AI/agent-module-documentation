# Plugin types

Geofield Map defines two plugin types (managers in `geofield_map.services.yml`).

## MapThemer — `Plugin/GeofieldMapThemer`

Vary map marker icons (and a legend) by dynamic data on the **Geofield Google Map Views
style**. Used from the Views style's `map_marker_and_infowindow → theming` options.

- Manager service: `plugin.manager.geofield_map.themer`
  (`Drupal\geofield_map\MapThemerPluginManager`), subdir `Plugin/GeofieldMapThemer`.
- Interface: `Drupal\geofield_map\MapThemerInterface`; base class `MapThemerBase`.
- Discovery: attribute `Drupal\geofield_map\Attribute\MapThemer` (legacy annotation
  `Drupal\geofield_map\Annotation\MapThemer` also supported).
- Alter hook: `geofield_map_themer_info`.

Attribute properties: `id`, `name` (TranslatableMarkup), `description`, `context` (e.g.
`["ViewStyle"]`), `weight`, `markerIconSelection` (e.g. `{"type":"file_uri",
"configSyncCompatibility":true}`), `defaultSettings`, `deriver`.

Key interface methods to implement: `getName()`, `getDescription()`,
`defaultSettings($k = NULL)`, `buildMapThemerElement($defaults, &$form, $form_state,
$geofieldMapView)` (the settings sub-form), `getIcon($datum, $geofieldMapView, $entity,
$map_theming_values)` (return the icon for a feature), `getLegend($map_theming_values,
$configuration = [])`.

Bundled MapThemers (`src/Plugin/GeofieldMapThemer/`): `geofieldmap_list_fields_url`
(List/Options field → image), plus taxonomy-term and entity-type themers.

## LeafletTileLayerPlugin — `Plugin/LeafletTileLayerPlugin`

Register a Leaflet base tile layer selectable when the widget/map uses the Leaflet library.

- Manager service: `plugin.manager.leaflet_tile_layer_plugin`
  (`Drupal\geofield_map\LeafletTileLayerPluginManager`), subdir `Plugin/LeafletTileLayerPlugin`.
- Base class: `LeafletTileLayerPluginBase`; attribute
  `Drupal\geofield_map\Attribute\LeafletTileLayerPlugin` (annotation also supported).
- Bundled layers include OpenStreetMap Mapnik, OpenTopoMap, Esri World Topo/Street,
  Stamen Toner/Terrain/Watercolor, Google Maps Roads.

## Legend block

`geofield_map_legend` (`src/Plugin/Block/GeofieldMapLegend.php`) renders a MapThemer's
legend as a placeable block.
