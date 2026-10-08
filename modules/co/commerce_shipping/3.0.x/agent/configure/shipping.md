# Configure shipping

## Enable shipping (setup order)

1. Install `commerce_shipping`.
2. Product variation type → enable the **Shippable** trait (`purchasable_entity_shippable`)
   on each variation type that ships (adds a weight field).
3. Order type (Commerce → Configuration → Orders → Order types): check **Enable shipping
   for this order type**, pick a **Shipping type** (shipment type), and select the
   **Shipping** checkout flow (or move the *Shipping information* pane into the Default flow).
   This third-party setting is stored under
   `commerce_order.commerce_order_type.*.third_party.commerce_shipping.shipment_type`.
4. (With Commerce Tax) create a **Shipping** tax type so shipping is taxed.

Top-level config menu: `/admin/commerce/config/shipping` (route
`commerce_shipping.configuration`, permission `access commerce administration pages`).

## Shipping methods — `commerce_shipping_method` (content entity)

Manage at `/admin/commerce/shipping-methods` (add: `/admin/commerce/shipping-methods/add`).
Each method is store-scoped, references one **shipping-method plugin**, and can be limited by
**condition plugins**. Built-in plugins: `flat_rate` (single fee; keys `rate_label`,
`rate_description`, `rate_amount` [a `commerce_price`]) and `flat_rate_per_item` (fee × total
quantity). Shared plugin config: `default_package_type`, `services[]`, `workflow`.

Condition plugins (config schema `commerce_shipping.schema.yml`):
| Condition id | Limits by |
|---|---|
| `shipment_address` | destination address zone |
| `shipment_weight` | weight (`operator`, `weight`, `max_weight`) |
| `shipment_quantity` | item count (`operator`, `quantity`) |
| `order_shipping_method` | selected shipping method(s) |

## Shipment types — `commerce_shipment_type` (config entity)

Bundles of `commerce_shipment`, at `/admin/commerce/config/shipment-types`. `config_export`:
`profileType`, `traits`, `sendConfirmation`, `confirmationBcc` (BCC for confirmation email).
Default bundle `default` ships in `config/install`.

## Package types — `commerce_package_type` (config entity)

Boxes with fixed `dimensions` + `weight` (uses `physical`), at
`/admin/commerce/config/package-types`. A `custom_box` type is defined in
`commerce_shipping.commerce_package_types.yml`; package-type **plugins** are also derived from
these config entities via `PackageTypeDeriver`.

## Checkout pane — `shipping_information`

Config schema `commerce_checkout.commerce_checkout_pane.shipping_information`:
- `auto_recalculate` (bool) — recalc rates when the shipping address changes.
- `require_shipping_profile` (bool) — hide shipping costs until an address is entered.

## Permissions (`commerce_shipping.permissions.yml`)

`administer commerce_shipment`, `administer commerce_shipping_method`,
`administer commerce_shipment_type`, `administer commerce_package_type` — all
`restrict access: TRUE`.

## Adjustments / workflow

Order total gains `shipping` and `shipping_promotion` adjustment types. Shipments run the
`shipment_default` workflow: states draft → ready → shipped (+ canceled), transitions
`finalize`, `ship`, `cancel`.
