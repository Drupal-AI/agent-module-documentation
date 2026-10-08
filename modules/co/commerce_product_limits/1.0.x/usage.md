Commerce Product Limits adds per-variation **minimum**, **maximum**, and **step** order-quantity limits to Drupal Commerce, enforcing them at add-to-cart / cart update and reflecting them as HTML min/max/step attributes on the quantity fields.

---

The module ships three Commerce **entity trait** plugins for the `commerce_product_variation` entity
type — `minimum_order_quantity` ("Minimum order quantity"), `maximum_order_quantity` ("Maximum order
quantity"), and `step_order_quantity` ("Step order quantity"). Enabling a trait on a product
variation **type** (via its edit form, or programmatically) installs a matching unsigned-integer
`BundleFieldDefinition` field (`minimum_order_quantity` / `maximum_order_quantity` /
`step_order_quantity`) on that variation type; you then set a value per variation. Enforcement has two
parts. First, an **AvailabilityChecker** service (`commerce_product_limits.availability_checker`,
tagged `commerce_order.availability_checker`) is consulted by Commerce Core's Availability Manager for
every product-variation order item: if the requested quantity — including any matching quantity
already in the cart — is below the variation's `minimum_order_quantity` or above its
`maximum_order_quantity`, it returns `AvailabilityResult::unavailable()` with a message ("You must
order at least @min…" / "You cannot order more than @max…"), so the add/update is rejected. Second,
two form alters set the HTML `#min` / `#max` / `#step` attributes (and the add-to-cart default
quantity) on the **Add to cart** form and on the core **Shopping cart** view form for client-side
validation. The module has no admin settings page, no permissions, and no config schema of its own.
Note: it is **not compatible with Commerce Cart Flyout**.

---

- Require customers to buy at least N units of a product (minimum order quantity).
- Cap how many units of a product a customer can buy in one order (maximum order quantity).
- Sell a product only in multiples (step) — e.g. packs of 6 — via the step trait.
- Enforce a wholesale minimum order size on specific product variations.
- Prevent over-ordering of scarce/limited-stock items with a maximum per order.
- Set different min/max limits per variation (e.g. per size or colour) within a product.
- Show the correct min/max on the add-to-cart quantity field so shoppers see limits up front.
- Reject a cart update that pushes a line item above its maximum quantity.
- Combine the already-in-cart quantity with the new request when checking the maximum.
- Pre-fill the add-to-cart quantity to the minimum so shoppers can't submit below it.
- Apply purchase limits without writing custom availability code.
- Enable limits only on the variation types that need them by toggling the traits.
- Provide "minimum order value" style rules at the quantity level for B2B stores.
- Constrain a subscription/starter-pack product to a fixed step increment.
- Add HTML5 min/max/step attributes for basic client-side validation on quantity inputs.
- Enforce server-side limits even if the client bypasses the HTML attributes (AvailabilityChecker).
- Set a per-product maximum to discourage bulk resellers.
- Roll out quantity limits across a catalogue by enabling a trait on a shared variation type.
- Give a store minimum-purchase rules that surface a clear error message at add-to-cart.
- Remove a limit by clearing the field value on a variation (empty = unrestricted) or disabling the trait.
