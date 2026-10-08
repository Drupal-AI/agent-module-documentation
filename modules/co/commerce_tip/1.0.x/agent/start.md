<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Tip — agent index

Adds an **optional tip/gratuity checkout pane** to Drupal Commerce. Version **1.0.x**. Core `^9.2 || ^10`.
Depends on `commerce`, `commerce_checkout`.

The tip is a customer-entered amount applied as an order adjustment and rolled into the order total/payment.
Configured per checkout flow at `/admin/commerce/config/checkout-flows`. No custom routes, no callbacks, no own
permissions. Amount is intentionally customer-controlled (voluntary tip) — not a price-manipulation flaw.
