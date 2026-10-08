# Geolocation plugin types

Geolocation defines many plugin types (managers in `geolocation.services.yml`, base classes and
interfaces in `src/`, discovery via `src/Attribute/` attributes or legacy `src/Annotation/`).
Plugins live in `src/Plugin/geolocation/<Type>/` (module or submodule).

| Plugin type | Attribute / manager | Purpose |
|---|---|---|
| MapProvider | `MapProvider` / `plugin.manager.geolocation.mapprovider` | A rendering backend (Google, Leaflet, HERE, Baidu, Yandex). |
| MapFeature | `MapFeature` / `...mapfeature` | Optional map behaviors: markers, clustering, controls, popups, drawing. |
| MapCenter | `MapCenter` / `...mapcenter` | How the map chooses its center/zoom (fit bounds, fixed, client location). |
| TileLayerProvider | `TileLayerProvider` / `...tilelayerprovider` | Base tile layers for Leaflet-style maps. |
| LayerFeature | `LayerFeature` / `...layerfeature` | Features attached to a specific map layer. |
| DataLayerProvider | `DataLayerProvider` / `...datalayerprovider` | Supplies data layers to a map. |
| DataProvider | `DataProvider` / `...dataprovider` | Extracts geolocation data from a field/source for maps. |
| Geocoder | `Geocoder` / `...geocoder` | Turns an address string into coordinates (and reverse). |
| GeocoderCountryFormatting | `GeocoderCountryFormatting` / `...geocoder_country_formatting` | Per-country address formatting for geocoders. |
| Location | `Location` / `...location` | Named location strategy (e.g. a fixed point, user location). |
| LocationInput | `LocationInput` / `...locationinput` | Input method for a location on forms/exposed filters. |

## Implementing one (example: a MapFeature)
```php
namespace Drupal\my_module\Plugin\geolocation\MapFeature;

use Drupal\geolocation\Attribute\MapFeature;
use Drupal\geolocation\MapFeatureBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[MapFeature(
  id: 'my_heatmap',
  name: new TranslatableMarkup('Heatmap'),
  description: new TranslatableMarkup('Render markers as a heatmap.'),
  type: 'google_maps',
)]
class Heatmap extends MapFeatureBase {
  // Attach JS settings/library via getMapFeatureSettings()/alterMap().
}
```
Extend the matching `*Base` class and implement its interface; attach front-end behavior with a
library. Reuse `BoundaryTrait`, `ProximityTrait`, `ViewsContextTrait` where relevant.
