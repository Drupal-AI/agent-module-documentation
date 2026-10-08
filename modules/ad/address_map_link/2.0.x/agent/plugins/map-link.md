<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The MapLink plugin type

The module defines a plugin type so map providers are pluggable.

- **Manager:** `plugin.manager.map_link` (`Drupal\address_map_link\MapLinkManager`, extends
  `DefaultPluginManager`). Discovers plugins in `Plugin/MapLink`, alter hook
  `address_map_link_map_link_info`.
- **Interface:** `Drupal\address_map_link\MapLinkInterface` — `getName(): string` and
  `getAddressUrl(AddressInterface $address): Url`.
- **Base class:** `Drupal\address_map_link\MapLinkBase` — implements `getName()` (from the annotation)
  and a helper `addressString(AddressInterface)` that concatenates address line 1/2, locality,
  administrative area, dependent locality, postal code and country code into a query string.
- **Annotation:** `@MapLink(id="...", name=@Translation("..."))`.

## Shipped providers

`google_maps`, `google_maps_directions`, `apple_maps`, `bing_maps`, `here_wego_maps`, `mapquest`,
`openstreetmap`, `yandex_maps`, `waze_directions`, `waze_navigate`.

## Add your own provider

Create `src/Plugin/MapLink/MyMaps.php` in a custom module:

```php
namespace Drupal\my_module\Plugin\MapLink;

use Drupal\address\AddressInterface;
use Drupal\address_map_link\MapLinkBase;
use Drupal\Core\Url;

/**
 * @MapLink(
 *   id = "my_maps",
 *   name = @Translation("My Maps")
 * )
 */
class MyMaps extends MapLinkBase {

  public function getAddressUrl(AddressInterface $address): Url {
    return Url::fromUri('https://maps.example.com/', ['query' => ['q' => $this->addressString($address)]]);
  }

}
```

Override only `getAddressUrl()` (and optionally the query building) — `getName()` comes from the base
class using the annotation `name`. Clear caches and `my_maps` becomes selectable in the formatter's
"Map Link Type" dropdown. The dropdown options come from
`MapLinkManager::getDefinitionsOptionsList()` (plugin id → `name`, sorted).
