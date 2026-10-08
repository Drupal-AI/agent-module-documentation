<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Order Percentage (commerce_shipping_order_percentage) — agent index

**Commerce shipping-method plugin `percentage_of_order_value` that charges `subtotal * percentage / 100`, clamped to optional min/max.**

- **Version:** 1.1.x
- **Core:** ^9.5 || ^10 || ^11
- **Dependencies:** commerce, commerce_order, commerce_price
- **Plugin:** `Drupal\commerce_shipping_order_percentage\Plugin\Commerce\ShippingMethod\PercentageOfOrderValue` (id `percentage_of_order_value`).
- **Service:** `commerce_shipping_order_percentage.ratelookup` (`RateLookupService::getRates()`), plus autowired `Hook\Hooks`.
- **Config:** per shipping-method entity — `rate_label`, `shipping_settings.percentage`, `.minimum_charge`, `.maximum_charge`.
- **Setup:** add a shipping method at `/admin/commerce/shipping-methods`, pick "Percentage of Order value".
- **Security:** no routes, no permissions of its own, no anonymous surface; configured behind Commerce's shipping-method admin access. Returns no rate when the shipment has no address. No security findings.

See [configure/shipping-method.md](configure/shipping-method.md)
