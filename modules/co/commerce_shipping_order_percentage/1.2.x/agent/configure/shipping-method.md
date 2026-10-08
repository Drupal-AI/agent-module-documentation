<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the percentage shipping method

## Add the method
`/admin/commerce/shipping-methods` → **Add shipping method** → plugin **Percentage of Order value**.

## Settings (`shipping_settings`)
- `rate_label` (required) — label shown to customers when selecting the rate. Default "Direct to your door".
- `percentage` (required) — percent of order subtotal to charge; number field, step `any`, `#min` 0 (e.g. `10`, `17.5`). No `%` sign. Default 10.
- `minimum_charge` — floor applied when the computed rate is below it; `0`/empty disables the floor. Default 0.
- `maximum_charge` — cap applied when the computed rate exceeds it; `0`/empty disables the cap. Default 150.

Validation: `validateConfigurationForm()` errors if `minimum_charge > maximum_charge` (only when a maximum is set). `submitConfigurationForm()` casts each value to `float`.

## Rate calculation
`PercentageOfOrderValue::calculateRates(ShipmentInterface $shipment)`:
1. Reads `$subtotal = $shipment->getOrder()->getSubtotalPrice()` and the shipping profile. Returns `[]` if there is no subtotal, no profile, or the profile `address` is empty.
2. `$amount = $subtotal->multiply((string) percentage)->divide('100')` — `commerce_price` `Price` arithmetic in the **order subtotal's currency** (`$subtotal->getCurrencyCode()`).
3. Clamp: if `minimum_charge > 0`, raise `$amount` to a `Price(min, currency)` when `$amount->lessThan($min)`; if `maximum_charge > 0`, cap it to `Price(max, currency)` when `$amount->greaterThan($max)`.
4. Rounds with `commerce_price.rounder` (`$this->rounder->round($amount)`) and returns one `ShippingRate` for the `default` service, `shipping_method_id` = parent entity id.

The percentage, min and max are read only from `$this->configuration['shipping_settings']` (admin config); no request/customer input feeds the amount beyond the order subtotal itself, which Commerce computes server-side from order items.
