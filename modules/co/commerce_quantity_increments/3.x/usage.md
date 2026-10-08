Commerce Quantity Increments lets each Drupal Commerce product variation be sold only in a configured quantity step (e.g. multiples of 6), validating the entered quantity on the add-to-cart form and the cart update form.

---

The module adds a single `qty_increments` base field to every `commerce_product_variation`. When that field holds a value greater than zero, the module treats it as both the minimum orderable quantity and the required step: a customer may only order the increment itself or an exact multiple of it. It hooks the Commerce add-to-cart form (`commerce_order_item_add_to_cart_form`) and the default Views-based cart form (`views_form_commerce_cart_form_default`), setting the HTML `min`/`step`/`default_value` on the quantity element and attaching a server-side `#element_validate` callback that rejects any quantity below the increment or not divisible by it, showing "This product is available for purchase in increments of @increments only." Values with no decimal fraction are treated as integers, fractional values stay floats. There is no settings form, no permission, no config object, and no submodule — configuration is per variation via the field on the variation edit form. A blank or zero `qty_increments` leaves the variation unrestricted (normal quantity behaviour).

---

- Sell a product only in packs, e.g. multiples of 6, by setting `qty_increments` to 6 on the variation.
- Enforce a per-variation minimum order quantity (the increment value doubles as the minimum).
- Require case/box quantities for wholesale or B2B catalogs.
- Configure different increments for different variations of the same product (per-variation, not per-product).
- Allow fractional increments (e.g. 0.5 kg steps) — the module keeps the value as a float when it has a fraction.
- Block "add 1" for a bulk-only item — an order of 1 against a step of 6 fails validation.
- Show the correct step arrows and minimum in the quantity number field on the product page.
- Pre-fill the add-to-cart quantity with the increment so the first suggested amount is already valid.
- Validate the quantity again when a customer edits it directly in the shopping cart view.
- Give a clear, translatable error message naming the required increment when an invalid amount is entered.
- Leave a variation unrestricted by clearing (or setting to 0) its `qty_increments` value.
- Combine with normal Commerce pricing/promotions — the module only constrains quantity, not price.
- Sell chemicals, cabling, fabric, or feed in fixed measured lots.
- Model "minimum order + reorder step" (same value) without writing custom code.
- Expose the increment value on the variation display (the field is display-configurable for view).
- Add the quantity input to the add-to-cart form automatically on install (the install hook ensures the quantity component is shown on the `add_to_cart` form display of `product_variation`).
- Restrict who can edit the increment by controlling access to product-variation editing.
- Keep the storefront UX consistent — the same increment drives both the step attribute and the validation.
- Support Drupal 10 and 11 with Commerce 2.29+ or Commerce 3.
- Serve as a lightweight, dependency-light alternative to writing a custom order-item quantity constraint for simple pack-size needs.
- Audit that the increment configured on each variation matches how the product is actually stocked and sold before going live.
