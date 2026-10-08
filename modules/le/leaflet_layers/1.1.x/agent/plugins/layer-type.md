# LayerType plugins

Custom `map_layer` entities are rendered from **LayerType** plugins. Each plugin's `getInfo()`
returns a `settings` array of Form-API elements; `MapLayerForm` renders those fields per plugin and
stores the submitted values (plus `plugin_type` and `layer_type`) in the entity's `settings`.

## Manager & discovery

- Manager service: `plugin.manager.leaflet_layers` (`LayerTypePluginManager`, parent
  `default_plugin_manager`).
- Directory: `src/Plugin/LeafletLayerType/`. Annotation: `@LayerType` (`id`, `label`).
- Interface: `Drupal\leaflet_layers\LayerTypeInterface` (one method `getInfo()`).
- Base class: `LayerTypePluginBase`. Alter hook: `hook_leaflet_layers_layer_type_alter()`.
- Cache key: `leaflet_layers_layer_type`.

## Shipped plugins

| id | class | Adds |
|---|---|---|
| `tilelayer` | `Plugin/LeafletLayerType/TileLayer` | `urlTemplate`, `attribution`, `minZoom`, `maxZoom`, `opacity`, `subdomains`, `errorTileUrl`, `zoomOffset`, `tms`, `zoomReverse`, `detectRetina`. |
| `wms` | `Plugin/LeafletLayerType/Wms` (extends `TileLayer`) | `layers`, `styles`, `format` (default `image/jpeg`), `transparent`, `version` (default `1.1.1`), `uppercase`, plus all TileLayer fields (with `urlTemplate` relabeled "WMS Url"). |

## Implement a new LayerType

```php
namespace Drupal\my_module\Plugin\LeafletLayerType;

use Drupal\leaflet_layers\LayerTypePluginBase;
use Drupal\leaflet_layers\LayerTypeInterface;

/**
 * @LayerType(
 *   id = "my_layer",
 *   label = "My Layer",
 * )
 */
class MyLayer extends LayerTypePluginBase implements LayerTypeInterface {
  public function getInfo() {
    return [
      'settings' => [
        'urlTemplate' => ['#type' => 'textfield', '#title' => t('URL'), '#default_value' => ''],
        // …any Form-API elements; each key becomes a settings key on the map_layer entity.
      ],
    ];
  }
}
```

`getInfo()['settings']` keys with `#type => 'checkbox'` are cast to real booleans when the bundle is
emitted (`leaflet_layers_leaflet_map_info()`); `minZoom`/`maxZoom`/`zoomOffset` are cast to int and
`opacity` to float by `MapLayer::getSettings()`. The whole `settings` array (minus `plugin_type`) is
passed to Leaflet as the layer's `options`, so key names must match Leaflet layer option names.
