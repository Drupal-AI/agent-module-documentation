# FedEx Service plugin type

The module defines a plugin type for FedEx **special services / package logic**. Each plugin can
split a shipment into multiple FedEx packages and/or adjust a package before it is rated.

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.commerce_fedex_service` (`Drupal\commerce_fedex\FedExPluginManager`) |
| Discovery directory | `Plugin/Commerce/FedEx` |
| Annotation | `@CommerceFedExPlugin` (`src/Annotation/CommerceFedExPlugin.php`) |
| Interface | `FedExPluginInterface` |
| Base class | `FedExPluginBase` (implements `ContainerFactoryPluginInterface`, `ConfigurableInterface`, `PluginFormInterface`, `DependentPluginInterface`) |
| Alter hook | `hook_commerce_fedex_info_alter()` (alter id `commerce_fedex_info`) |
| Plugin cache | `commerce_fedex_plugins` |

Annotation keys: `id`, `label`, `options_label`, `options_description` (the last two title/describe
the plugin's sub-details section on the shipping-method form).

## Interface contract

```php
// Reorganize a package's items into one or more FedEx packages.
public function splitPackage(array $shipment_items, ShipmentInterface $shipment): array;

// Modify a single FedexRest\Entity\Item before it is rated.
public function adjustPackage(FedexRest\Entity\Item $package, array $shipment_items, ShipmentInterface $shipment): Item;
```

Plus the standard `PluginFormInterface` / `ConfigurableInterface` methods for per-plugin config,
which are stored under the shipping method's `plugins` config sequence. `FedExPluginBase` provides
no-op defaults (`splitPackage` returns the items unchanged; `adjustPackage` returns the package
unchanged), so subclasses override only what they need.

The shipping method loads every discovered plugin into a `DefaultLazyPluginCollection` and, in
`FedEx::splitPackages()` / `FedEx::adjustPackage()`, chains **all** plugins in sequence over the
packages during rate building.

## Add a plugin

Create `your_module/src/Plugin/Commerce/FedEx/MyService.php`:

```php
namespace Drupal\your_module\Plugin\Commerce\FedEx;

use Drupal\commerce_fedex\Plugin\Commerce\FedEx\FedExPluginBase;
use Drupal\commerce_shipping\Entity\ShipmentInterface;
use FedexRest\Entity\Item;

/**
 * @CommerceFedExPlugin(
 *   id = "my_service",
 *   label = @Translation("My FedEx service"),
 *   options_label = @Translation("My service options"),
 *   options_description = @Translation("Global options for my service")
 * )
 */
class MyService extends FedExPluginBase {
  public function adjustPackage(Item $package, array $shipment_items, ShipmentInterface $shipment): Item {
    // e.g. attach a PackageSpecialServicesRequested to $package.
    return $package;
  }
}
```

## Bundled plugins (the two submodules)

Both submodules are packaged in this tarball but marked **experimental / not ready for use**. They
are separate modules you enable, not documented in full here:

- **`commerce_fedex_dangerous`** — plugin id `dangerous` (`DangerousGoodsPlugin`). Adds a
  `fedex_dangerous` Commerce **entity trait** (field `fedex_dangerous_accessibility` on product
  variations); `splitPackage()` groups items by dangerous-goods status and `adjustPackage()` attaches
  a `DangerousGoodsDetail` special service. Config key: `contact_number`.
- **`commerce_fedex_dry_ice`** — plugin id `dry_ice` (`DryIcePlugin`). Adds a `fedex_dry_ice` entity
  trait (boolean fields `fedex_dry_ice_domestic` / `fedex_dry_ice_intl`); separates dry-ice items
  into their own packages and attaches the `DRY_ICE` special service with a configured package type
  and weight (per domestic/international). Throws if a package mixes dry-ice and non-dry-ice items.

Both also register a (currently stub) `RateRequestEvent` subscriber. Use them as reference
implementations for `splitPackage` / `adjustPackage`.
