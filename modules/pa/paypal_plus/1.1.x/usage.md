<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paypal Plus is a lightweight, non-Commerce PayPal payment integration. It lets a site take a one-off PayPal payment through a simple amount form, a placeable pay block, or a Webform submit handler, using the PayPal Orders v2 REST API. It is aimed at sites that want to collect a payment without installing Drupal Commerce.

---

Configuration lives at `/admin/paypal-configurations` (route `paypal_plus.configurations`, gated by `administer site configuration`) where you set sandbox/live client id + secret, currency, and mode; values are stored in `paypal_plus.settings`. The `PayPal` service (`paypal_plus`) wraps a vendored srmklive-style PayPal client (OAuth token + Orders API traits) and TLS is enabled by default (`CURLOPT_SSL_VERIFYPEER` defaults to true). `paypalPay()` creates a PayPal order and redirects the buyer to PayPal's approval URL; on return, `PaypalController::payment_success()` reads the PayPal `token`, calls `capturePaymentOrder($token)` server-to-server, and only shows success when PayPal itself reports `status == COMPLETED` — success is not derived from request parameters. A set of hooks (`paypal_plus_success_redirect`, `paypal_plus_set_item_ids`, `paypal_plus_success_message`, etc.) let integrators plug in order fulfilment and redirects. Depends on core `block`. Note (see agent notes): the success capture is authoritative (re-fetched from PayPal), so a forged return URL cannot mark a payment complete without a real captured PayPal order — but this module does not itself bind the captured amount to any Drupal order entity; fulfilment is delegated to your hook implementations, which must do that binding.

---

- Collect a one-off PayPal payment without installing Drupal Commerce.
- Add a "pay this amount" form to a page for donations or simple sales.
- Place a PayPal pay block in any region via Block Layout.
- Take payment as part of a Webform submission using the bundled handler.
- Drive the amount from a Webform field or a fixed configured value.
- Switch between PayPal sandbox and live via a single settings toggle.
- Configure client id/secret and currency from one admin form.
- Capture the order server-side on return so success reflects PayPal's real status.
- Plug in custom fulfilment logic via `paypal_plus_*` hooks.
- Redirect buyers to custom success/failure/cancel pages through hooks.
- Set order/item ids in session for post-payment processing.
- Localize the payment currency per configuration.
- Keep TLS verification on for PayPal API calls (secure by default).
- Provide branded success/failure messages via hooks.
- Integrate PayPal into an existing content workflow with minimal code.
- Support event tickets, fees, or pay-what-you-want flows with a simple form.
