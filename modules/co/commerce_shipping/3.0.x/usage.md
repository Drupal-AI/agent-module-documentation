Commerce Shipping adds shipping to Drupal Commerce: it packs an order's shippable items into shipment entities, calculates rates through pluggable shipping methods (flat rate, per-item, carrier plugins), and collects a shipping address and rate choice through a checkout pane.

---

Commerce Shipping introduces two content entities — `commerce_shipment` (an order's parcel: items, weight, package type, shipping profile, method, service, rate amount and a state-machine workflow of draft → ready → shipped) and `commerce_shipping_method` (a configurable, store-scoped, condition-filtered entity wrapping a shipping-method plugin) — plus two config entities, `commerce_shipment_type` (a shipment bundle) and `commerce_package_type` (box dimensions/weight). Shipping methods are a plugin type (`plugin.manager.commerce_shipping_method`, namespace `Plugin/Commerce/ShippingMethod`, attribute `#[CommerceShippingMethod]`); the module ships `flat_rate` and `flat_rate_per_item`, and carriers add their own by extending `ShippingMethodBase` and implementing `calculateRates()`. Rates and packages are represented by immutable value objects: `ShippingRate` (method id, service, `Price` amount, description), `ShipmentItem` (order item id, title, quantity, `physical\Weight`, declared value) and `ShippingService`. Orders are packed into shipments by the `PackerManager` (a service-collector of tagged `commerce_shipping.packer` services, default and admin packers included), producing `ProposedShipment` objects that populate real shipments. At checkout the `shipping_information` pane collects the shipping profile, packs the order, and renders selectable rates; two order processors (`EarlyOrderProcessor` priority 200, `LateOrderProcessor` priority -100) repack and add shipping/`shipping_promotion` adjustments to the order total. Shipping methods can be limited with condition plugins (`shipment_address`, `shipment_weight`, `shipment_quantity`, `order_shipping_method`), and the module also provides promotion offers (fixed/percentage off shipping), a `shipping` tax type, purchasable-entity traits (`purchasable_entity_shippable`, dimensions), field types/widgets/formatters, and a shipment confirmation email. It depends on `commerce`, `commerce_order`, `commerce_price` and `physical` (for weight/dimensions), and uses the `profile` entity for the shipping address.

---

- Charge a single flat shipping fee per order with the built-in `flat_rate` shipping method.
- Charge a flat fee per item/quantity with the `flat_rate_per_item` shipping method.
- Make a product variation type shippable by enabling the `purchasable_entity_shippable` trait.
- Enable shipping on an order type and assign it the Shipping checkout flow.
- Collect a shipping address and let customers pick a rate via the `shipping_information` checkout pane.
- Split an order into multiple shipments automatically with a custom packer service.
- Restrict a shipping method to certain destinations with the `shipment_address` condition.
- Offer a method only above/below a weight threshold with the `shipment_weight` condition.
- Limit a method by item count with the `shipment_quantity` condition.
- Scope a shipping method to specific stores.
- Add a real-time carrier (UPS/USPS/FedEx) by writing a `#[CommerceShippingMethod]` plugin that returns `ShippingRate` objects.
- Expose multiple named services (Ground, Express) from one shipping method plugin.
- Define custom package/box types with fixed dimensions and weight (`commerce_package_type`).
- Give a shipment its own workflow state (draft → ready → shipped → canceled).
- Track a shipment with a tracking number/link via the tracking field formatter.
- Send an automatic shipment confirmation email when an order ships.
- Calculate rates programmatically for a shipment with the `commerce_shipping.shipment_manager` service.
- Add a shipping fee off/discount as a promotion offer (fixed amount or percentage off shipping).
- Tax shipping costs by creating a `shipping` tax type (with Commerce Tax).
- React to shipment lifecycle via `ShippingEvents` (create, presave, insert, rates calculated, etc.).
- Filter which shipping methods are offered for a shipment via the `FILTER_SHIPPING_METHODS` event.
- Manage shipments per order in the admin UI under an order's Shipments tab.
- Create additional shipment types (bundles) with their own fields and profile type.
- Read an order's shipping profile/shipments with the `commerce_shipping.order_manager` service.
- Alter the list of shipping method plugins via the `commerce_shipping_method_info` alter hook.
- Support weight-based logic anywhere by reusing the `physical\Weight` values on shipment items.
- Copy the shipping profile to/from the customer profile during checkout.
- Gate shipping administration with the `administer commerce_shipment` / `administer commerce_shipping_method` permissions.
