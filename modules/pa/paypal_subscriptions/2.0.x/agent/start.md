<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PayPal Subscriptions — agent index

Adds a PayPal Express Checkout **recurring** gateway to Drupal Commerce. Depends on
`commerce_payment` and `commerce_paypal`.

Quick facts:
- Gateway plugin: `ExpressCheckoutSubscriptions` (id `paypal_express_checkout_subscription`) extends `commerce_paypal`'s `ExpressCheckout`; configurable billing period (Day/Week/SemiMonth/Month/Year).
- Flow: `setExpressCheckout()` sends `L_BILLINGTYPE0=RecurringPayments`; `onReturn()` calls `GetExpressCheckoutDetails` (token from order data), then `CreateRecurringPaymentsProfile`; records a Commerce payment (state `authorization`, remote id = PROFILEID) only when `PROFILESTATUS == ActiveProfile`.
- Security: return handler re-fetches from PayPal via the server-issued order token; not a forgeable callback.
- Configured through the Commerce payment-gateway UI (no standalone route).
