<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Order Percentage (commerce_shipping_order_percentage) — agent index

**Commerce shipping-method plugin `percentage_of_order_value` that charges `subtotal * percentage / 100`, clamped to optional min/max charges.**

- **Version:** 1.2.x (1.2.0)
- **Core:** ^9.5 || ^10 || ^11
- **Dependencies:** commerce_shipping (Commerce Shipping ^2.0 || ^3.0)
- **Plugin:** `Drupal\commerce_shipping_order_percentage\Plugin\Commerce\ShippingMethod\PercentageOfOrderValue` (id `percentage_of_order_value`), extends `ShippingMethodBase`.
- **Services:** none of its own for rate calc — only the autowired `Hook\Hooks` (hook_help). Rate math is done inline in the plugin.
- **Config (per shipping-method entity):** `rate_label`, `shipping_settings.percentage`, `.minimum_charge`, `.maximum_charge`.
- **Setup:** add a shipping method at `/admin/commerce/shipping-methods`, pick "Percentage of Order value".
- **Security:** no routes, no permissions, no anonymous surface; configured behind Commerce's shipping-method admin access. Percentage/min/max come from admin plugin config only; the amount is recomputed server-side from `$order->getSubtotalPrice()`. Returns no rate when the shipment has no address. No security findings.

See [configure/shipping-method.md](configure/shipping-method.md)
