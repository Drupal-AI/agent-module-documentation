# Shipping plugins

## commerce_shipping_method — a shipping method / carrier

- Manager: `plugin.manager.commerce_shipping_method`
  (`Drupal\commerce_shipping\ShippingMethodManager`), discovery dir
  `Plugin/Commerce/ShippingMethod`, alter hook `commerce_shipping_method_info`.
- Attribute: `#[CommerceShippingMethod(id, label, services = [], workflow = 'shipment_default', deriver = NULL)]`
  (`src/Attribute/CommerceShippingMethod.php`; legacy annotation also supported). `services` is
  an array of service labels keyed by id.
- Interface `ShippingMethodInterface` extends `ConfigurableInterface`, `PluginFormInterface`,
  `DependentPluginInterface`, `ParentEntityAwareInterface`. Base class
  `Plugin/Commerce/ShippingMethod/ShippingMethodBase` (injects `plugin.manager.commerce_package_type`
  + `plugin.manager.workflow`).
- Key methods: `calculateRates(ShipmentInterface): ShippingRate[]` (the one you must implement),
  `applies(ShipmentInterface): bool`, `selectRate(ShipmentInterface, ShippingRate)`,
  `getServices()`, `getDefaultPackageType()`, `getWorkflowId()`, plus
  `defaultConfiguration()` / `buildConfigurationForm()` / `submitConfigurationForm()`.
- Built-ins: `flat_rate` (`FlatRate`) and `flat_rate_per_item` (`FlatRatePerItem` extends it,
  multiplies by `$shipment->getTotalQuantity()`).

### Add a carrier plugin

```php
namespace Drupal\my_carrier\Plugin\Commerce\ShippingMethod;

use Drupal\commerce_shipping\Attribute\CommerceShippingMethod;
use Drupal\commerce_shipping\Entity\ShipmentInterface;
use Drupal\commerce_shipping\Plugin\Commerce\ShippingMethod\ShippingMethodBase;
use Drupal\commerce_shipping\ShippingRate;
use Drupal\commerce_price\Price;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[CommerceShippingMethod(
  id: 'my_carrier',
  label: new TranslatableMarkup('My carrier'),
  services: ['ground' => 'Ground', 'express' => 'Express'],
)]
class MyCarrier extends ShippingMethodBase {

  public function calculateRates(ShipmentInterface $shipment): array {
    // $shipment->getWeight(), ->getItems() (ShipmentItem[]), ->getShippingProfile().
    return [
      new ShippingRate([
        'shipping_method_id' => $this->parentEntity->id(),
        'service' => $this->services['ground'],
        'amount' => new Price('9.99', 'USD'),
        'description' => '2-5 business days',
      ]),
    ];
  }
}
```

Then create a `commerce_shipping_method` entity that selects this plugin. Rates are cached and
altered via the `SHIPPING_RATES` event; the plugin's rates flow to the checkout pane and
`ShipmentManager::applyRate()` writes the chosen one onto the shipment.

## commerce_package_type — a box

- Manager: `plugin.manager.commerce_package_type` (`PackageTypeManager`), dir
  `Plugin/Commerce/PackageType`. Interface `PackageTypeInterface` exposes id, label, remote id,
  dimensions and weight (`physical`). Definitions are derived from `commerce_package_type`
  **config entities** by `PackageTypeDeriver`, and can be declared in
  `MODULE.commerce_package_types.yml`. A shipping method's `getDefaultPackageType()` returns one.

## Packers (services, not a plugin type)

Splitting an order into shipments is done by services tagged `commerce_shipping.packer`
(collected by `PackerManager`). Built-ins `DefaultPacker` (priority -100) and `AdminPacker`
(-200). Implement `PackerInterface` (`applies()`, `pack(): ProposedShipment[]`) and tag your
service to customize how items are grouped into parcels.
