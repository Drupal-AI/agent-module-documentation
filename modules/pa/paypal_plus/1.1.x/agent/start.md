<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paypal Plus — agent index

Standalone (non-Commerce) PayPal integration using the Orders v2 API. Pay form, pay block, and a
Webform handler. Depends on core `block`.

Quick facts:
- Config: `/admin/paypal-configurations` (route `paypal_plus.configurations`, perm `administer site configuration`); config object `paypal_plus.settings` (sandbox/live client id+secret, currency, sandbox mode).
- Service: `paypal_plus` (`PayPal`) wraps a vendored srmklive-style client; `paypalPay()` creates an order and redirects to PayPal's approve URL. TLS on by default (`CURLOPT_SSL_VERIFYPEER` defaults true).
- Return: `PaypalController::payment_success` (route `paypal_plus.payment_success`, `_access: TRUE`) reads `?token`, calls `capturePaymentOrder($token)` server-to-server, shows success only when PayPal returns `COMPLETED`.
- Extension points: `paypal_plus_success_redirect`, `paypal_plus_set_item_ids`, `paypal_plus_success_message`, etc. Fulfilment/amount-binding is the integrator's responsibility.
