<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Weight Tariff adds a shipping method that calculates the shipping rate from the total weight of an order.

---

Shipping cost frequently depends on weight — a heavier order costs more to send, in tiers or by rate-per-unit. Drupal Commerce's core shipping handles flat and per-item rates but not weight-tiered tariffs directly. This module adds a shipping method that reads the order's total weight and computes the rate from a configured tariff, so checkout charges the right amount for what is actually being sent.

It depends on Commerce Shipping and the product weights being populated — the calculation is only as good as the weight data on the products, so the operational prerequisite is that products carry accurate weights. It is a checkout-time calculation with no unusual security surface; the rate it produces is what the customer pays, so the configuration (the tariff bands) is the thing to get right.

For a store shipping physical goods where cost scales with weight, it is the missing rate method. Confirm product weights are set and the tariff bands match the carrier's pricing.

---

- Charge shipping by order weight.
- Add a weight-based shipping method.
- Compute tiered shipping rates.
- Price shipping for heavy orders.
- Configure weight tariff bands.
- Calculate rate from total weight.
- Ship physical goods by weight.
- Match carrier weight pricing.
- Add weight tiers to checkout.
- Require accurate product weights.
- Provide a weight rate method.
- Charge more for heavier carts.
- Configure a shipping tariff.
- Base shipping on cart weight.
- Set weight bands.
- Integrate with Commerce Shipping.
- Price parcels by weight.
- Handle weight-scaled shipping.
- Confirm product weights are set.
- Calculate accurate postage.