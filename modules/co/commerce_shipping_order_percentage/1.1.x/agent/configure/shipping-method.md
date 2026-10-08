<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the percentage shipping method

## Add the method
`/admin/commerce/shipping-methods` → **Add shipping method** → plugin **Percentage of Order value**.

## Settings (`shipping_settings`)
- `rate_label` (required) — label shown to customers when selecting the rate.
- `percentage` (required) — percent of order subtotal to charge; step 0.01 (e.g. `10`, `17.5`). No `%` sign.
- `minimum_charge` — floor applied when the computed rate is below it (default 0).
- `maximum_charge` — cap applied when the computed rate exceeds it; `0`/empty disables the cap (default 150).

Validation: `validateConfigurationForm()` errors if `minimum_charge > maximum_charge` (when max is set).

## Rate calculation
`PercentageOfOrderValue::calculateRates()`:
1. Returns `[]` if the shipment's shipping profile address is empty.
2. Calls `RateLookupService::getRates($shipment, $config)` → `subtotal * percentage / 100`, then clamps to `[minimum_charge, maximum_charge]`.
3. Wraps the number in a `Price` using `currentStore->getStore()->getDefaultCurrencyCode()`, rounds via `commerce_price.rounder`, and returns one `ShippingRate` for the `default` service.

The rate lookup reads the order subtotal from `$shipment->getOrder()->getSubtotalPrice()`.
