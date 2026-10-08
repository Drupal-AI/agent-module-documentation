<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Order Percentage provides a `percentage_of_order_value` shipping-method plugin that calculates the shipping rate as a configurable percentage of the order subtotal, bounded by optional minimum and maximum charges.
---
The module addresses stores that want shipping cost to scale with cart value rather than weight or flat rate. It plugs into Commerce Shipping as a shipping-method plugin (`PercentageOfOrderValue`, extending `ShippingMethodBase`), so it is configured like any other rate: add a shipping method at `/admin/commerce/shipping-methods`, choose "Percentage of Order value", and set the percentage (e.g. `10`, `17.5`), an optional minimum charge and an optional maximum cap. The configuration form validates that the minimum is not greater than the maximum, and casts each value to a float on save.

Rate calculation happens inline in `calculateRates()`. It returns an empty list when the order has no subtotal or the shipment's shipping profile has no address; otherwise it computes the amount with `commerce_price` `Price` arithmetic — `subtotal->multiply(percentage)->divide('100')` — in the order subtotal's own currency, raises it to the minimum charge and caps it at the maximum charge when those are set, then rounds it with the Commerce rounder (`commerce_price.rounder`) and returns a single `ShippingRate` for the `default` service. The percentage, floor and cap are read only from the admin plugin configuration; no customer-supplied request input feeds the amount beyond the order subtotal, which Commerce derives server-side from the order items. All configuration lives on the shipping-method entity behind Commerce's own shipping-method admin access; the module defines no routes, no permissions, and no services beyond an autowired `hook_help` helper. No security findings.
---
- Add a "Percentage of Order value" shipping method at `/admin/commerce/shipping-methods`.
- Charge shipping as a flat 10% of the order subtotal.
- Charge a fractional percentage such as 17.5%.
- Set a minimum shipping charge so small orders still pay a floor amount.
- Set a maximum shipping charge to cap shipping on large orders.
- Leave the maximum at 0/empty to disable the upper cap.
- Leave the minimum at 0/empty to disable the lower floor.
- Give the rate a customer-facing label (e.g. "Direct to your door").
- Combine the method with Commerce shipping conditions to scope it to zones.
- Use it as an alternative to flat-rate or weight-based shipping.
- Offer percentage shipping only when a shipping address is present.
- Let shipping scale automatically as cart totals grow.
- Price the rate in the order subtotal's own currency for multi-currency stores.
- Round computed rates according to the store's Commerce rounding rules.
- Provide multiple percentage methods and let checkout pick between them.
- Validate that minimum charge never exceeds maximum charge on save.
- Model "handling as X% of order" fees via a dedicated method.
- Migrate from a flat rate to percentage-based shipping.
- Test rate output by placing orders of different subtotals.
- Disable the method by removing or unpublishing the shipping method entity.
