# Commerce Product Limits — agent index

Adds minimum / maximum / step order-quantity limits to Drupal Commerce **product variations**,
enforced at add-to-cart and cart update. No admin settings page, no permissions, no config schema.
Depends on `commerce_cart` + `commerce_product`.

- **Enabling the traits, the fields they add, and how limits are enforced** →
  [configure/limits.md](configure/limits.md)

Key facts:
- Three Commerce entity-trait plugins for `commerce_product_variation`:
  `minimum_order_quantity`, `maximum_order_quantity`, `step_order_quantity`
  (labels: "Minimum/Maximum/Step order quantity").
- Enabling a trait on a **product variation type** installs an unsigned-integer field of the same
  name; set the value per variation. Empty = no limit.
- Server-side enforcement: `AvailabilityChecker` (service
  `commerce_product_limits.availability_checker`, tag `commerce_order.availability_checker`) rejects
  order items below min / above max (counting quantity already in the cart).
- Client-side: form alters set HTML `#min`/`#max`/`#step` on the add-to-cart and core shopping-cart
  quantity fields; min also pre-fills the add-to-cart default quantity.
- Not compatible with Commerce Cart Flyout.
