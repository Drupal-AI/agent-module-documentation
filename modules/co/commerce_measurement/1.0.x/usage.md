<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Measurement provides Drupal Commerce condition plugins that evaluate the physical measurement fields of purchased product variations.

---

Commerce Measurement (project machine name `commerce_measurement`, "Commerce Measurement Condition") ships **two Commerce condition plugins** and nothing else — no routes, services, permissions, hooks, config schema, or settings page. Both read `physical_measurement` fields (weight, volume, area, length, temperature — whatever measurement types the **physical** module provides; the `physical_dimensions` field type is **not** supported) attached to `commerce_product_variation` bundles. `order_item_measurement` (`OrderItemMeasurement`, entity type `commerce_order_item`) compares a single order item's variation measurement against an admin-set threshold; `order_total_measurement` (`OrderItemTotalMeasurement`, entity type `commerce_order`) multiplies each item's measurement by its quantity, sums the per-field totals across the whole order, and compares that. Both extend `MeasurementBaseCondition`, which builds an AJAX table form (measurement type / field / operator / value) where each value uses a `physical_measurement` widget, discovers eligible fields by scanning every product variation type, and evaluates by converting the order's measurement into the condition's unit and comparing with `>=`, `>`, `<=`, `<`, or `==` via `physical\Measurement` value objects. Multiple configured rows are combined with **AND**. Conditions return a boolean only and never modify price, quantity, or order totals; Commerce Core uses that boolean to decide whether the host feature (a promotion, shipping method, payment gateway, or any condition-aware entity) applies. It depends on `commerce` and `physical`.

---

- Offer a promotion only when an order item's product variation weighs at or above a threshold (`order_item_measurement`).
- Restrict a shipping method or payment gateway by a variation's volume, area, or other physical measurement.
- Apply a rule based on the **whole order's total** measurement (quantity-weighted sum) with `order_total_measurement`.
- Combine several measurement fields in one condition — they are ANDed together.
- Compare with any of the operators `>=`, `>`, `<=`, `<`, `==` per row.
- Enter the comparison value with a unit; the module converts the order's measurement into that unit before comparing.
- Use the conditions anywhere Commerce Core supports conditions (promotions, shipping methods, payment gateways, checkout flows, etc.).
- Rely on measurement values sourced from product-variation fields provided by the Physical module — no separate configuration page and no access-control role.
