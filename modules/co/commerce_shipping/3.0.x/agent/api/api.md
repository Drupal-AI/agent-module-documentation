# Programmatic API — entities, value objects, services, events

## Entities

| Entity | Kind | Notes |
|---|---|---|
| `commerce_shipment` | content | An order parcel. Fields: order_id, items (`ShipmentItem[]`), shipping_profile, package_type, shipping_method, shipping_service, amount/original_amount, weight, tracking_code, state (`shipment_default` workflow). Storage `ShipmentStorage`, bundle = `commerce_shipment_type`. Admin URLs under `/admin/commerce/orders/{order}/shipments`. |
| `commerce_shipping_method` | content | Store-scoped, condition-filtered wrapper around a shipping-method plugin. Storage `ShippingMethodStorage`; translatable. |
| `commerce_shipment_type` | config | Shipment bundle (`profileType`, `traits`, `sendConfirmation`, `confirmationBcc`). |
| `commerce_package_type` | config | Box: `dimensions`, `weight`. |

```php
use Drupal\commerce_shipping\Entity\Shipment;

$shipment = Shipment::create(['type' => 'default', 'title' => 'Shipment']);
$shipment->setOrder($order)
  ->setItems($items)                 // ShipmentItem[]
  ->setShippingProfile($profile)
  ->setPackageType($package_type);
$shipment->save();
// getWeight(), getTotalQuantity(), getAmount() (Price), getState(), applyState()...
```

## Value objects (immutable, `new … ([...])`)

- `ShippingRate` — required keys `shipping_method_id`, `service` (`ShippingService`), `amount`
  (`commerce_price\Price`); optional `id`, `description`, `delivery_date`, `data`. Getters:
  `getService()`, `getAmount()`, `getOriginalAmount()`, `getDescription()`.
- `ShipmentItem` — required `order_item_id`, `title`, `quantity`, `weight`
  (`physical\Weight`), `declared_value` (`Price`); optional `tariff_code`. One order item may
  map to several shipment items depending on the packer.
- `ShippingService` — `new ShippingService($id, $label)`; `getId()`, `getLabel()`.
- `ProposedShipment` — packer output used to populate a real shipment
  (`Shipment::populateFromProposedShipment()`).

## Services

- `commerce_shipping.shipment_manager` (`ShipmentManagerInterface`) —
  `calculateRates($shipment): ShippingRate[]`, `applyRate($shipment, $rate)`,
  `selectDefaultRate($shipment, $rates)`.
- `commerce_shipping.order_manager` (`ShippingOrderManagerInterface`) —
  `isShippable($order)`, `hasShipments($order)`, `createProfile($order)`, `getProfile($order)`,
  `pack($order, $profile): ShipmentInterface[]`. Const `FORCE_REFRESH` (order data flag to
  force repack).
- `commerce_shipping.packer_manager` (`PackerManagerInterface`) — collects
  `commerce_shipping.packer`-tagged services; `pack()` returns proposed shipments.
- `plugin.manager.commerce_shipping_method`, `plugin.manager.commerce_package_type` — plugin
  managers (see [../plugins/shipping-method.md](../plugins/shipping-method.md)).
- `commerce_shipping.shipment_confirmation_mail` (`ShipmentConfirmationMailInterface`) — sends
  the shipment confirmation email.
- Order processors (tagged `commerce_order.order_processor`): `EarlyOrderProcessor`
  (priority 200, repacks) and `LateOrderProcessor` (priority -100, adds `shipping` adjustments).

## Events — `ShippingEvents`

- `FILTER_SHIPPING_METHODS` (`commerce_shipping.filter_shipping_methods`,
  `FilterShippingMethodsEvent`) — restrict methods offered for a shipment.
- `SHIPPING_RATES` (`commerce_shipping.rates`, `ShippingRatesEvent`) — alter calculated rates.
- Shipment lifecycle (`ShipmentEvent`): `SHIPMENT_LOAD`, `SHIPMENT_CREATE`, `SHIPMENT_PRESAVE`,
  `SHIPMENT_INSERT`, `SHIPMENT_UPDATE`, `SHIPMENT_PREDELETE`, `SHIPMENT_DELETE`.

The module defines no `*.api.php`; extension points are the plugin types, packer services, and
these events. It also provides promotion offers (`shipment_fixed_amount_off`,
`shipment_percentage_off`), a `shipping` tax type, and the `ShipmentItem` field type/widget.
