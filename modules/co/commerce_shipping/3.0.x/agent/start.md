# commerce_shipping — agent start

Adds shipping to Drupal Commerce. Packs an order's shippable items into **`commerce_shipment`**
content entities, calculates rates through **shipping-method plugins** wrapped by the
**`commerce_shipping_method`** content entity, and collects address + rate at checkout via the
`shipping_information` pane. Depends on `commerce`, `commerce_order`, `commerce_price`,
`physical` (weight/dimensions); uses `profile` for the shipping address. Config menu:
**Admin → Commerce → Configuration → Shipping** (`/admin/commerce/config/shipping`,
route `commerce_shipping.configuration`).

- Enable shipping, create shipping methods (flat rate) + conditions, shipment/package types, permissions → [configure/shipping.md](configure/shipping.md)
- ShippingMethod & PackageType plugin types; adding a carrier plugin → [plugins/shipping-method.md](plugins/shipping-method.md)
- Entities, value objects (ShippingRate/ShipmentItem), managers, packers, events → [api/api.md](api/api.md)
