<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce PayPal Dynamic Subscriptions (commerce_paypal_dynamic_subscriptions) — agent index

**Off-site Commerce payment gateway that creates recurring payments via the PayPal Subscriptions API.**

- **Version:** 1.0.x
- **Core:** ^10.2 || ^11
- **Package:** Commerce (contrib)
- **Dependencies:** commerce_paypal
- **Gateway plugin:** `DynamicSubscriptions` (src/Plugin/Commerce/PaymentGateway/DynamicSubscriptions.php), off-site (PaymentOffsiteForm)
- **Service:** `commerce_paypal_dynamic_subscriptions.checkout_sdk_factory` (wraps commerce_paypal's HTTP client / Checkout SDK)
- **Events:** `DynamicSubscriptionsEvents` (subscription create / cancel)
- **Security:** No custom routes — uses Commerce's off-site return/cancel handlers gated by order access. `onReturn()` re-fetches the subscription server-to-server via the merchant-authenticated PayPal API and verifies `plan_id` matches the order's stored plan before completing payment; the payment amount is `$order->getTotalPrice()`, not client input. TLS handled by the shared commerce_paypal Guzzle client (no disabled TLS). Observation: `onReturn` verifies plan match but does not additionally assert the subscription status is ACTIVE/APPROVED (see below) — minor.

See [api/gateway.md](api/gateway.md).
