<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Imoje integrates the imoje payment gateway (ING, Poland) with Drupal Commerce.

---

Commerce Imoje provides two Drupal Commerce payment gateway plugins for imoje: **imoje** (off-site paywall redirect — the shopper pays on imoje's ING page) and **imoje Blik** (on-site BLIK code entry driven by AJAX). Refunds can be issued from the Drupal order/payment admin. The order is confirmed by imoje's asynchronous notification (IPN).

Payment confirmation: when imoje posts its IPN to `/payment/notify/{payment_gateway_id}`, the handler (`IPNHandler::process`) verifies imoje's `X-Imoje-Signature` header — a keyed hash of the request payload with your gateway service key — FIRST, and rejects the request on a mismatch before any payment is recorded. Outbound calls to imoje use the core HTTP client (TLS verification on) against fixed imoje API hosts chosen by the gateway mode; the amount is computed server-side from the order. Store the imoje service key and API token as gateway configuration and keep exported config out of public version control. Depends on `commerce_payment`; supports Drupal per `^10.3 || ^11`.

---

- Integrate the imoje (ING, Poland) gateway with Drupal Commerce.
- Offer an off-site paywall redirect (`imoje_redirect`) and on-site BLIK (`imoje_blik`).
- Redirect the shopper to imoje, or take a BLIK code on-site and poll for the result.
- Complete the order after imoje's signed notification confirms the payment.
- Verify the `X-Imoje-Signature` on the IPN against the gateway service key before recording a payment.
- Compute the charged amount server-side from the order/payment.
- Call imoje's REST API with a Bearer token over TLS to fixed imoje hosts by mode.
- Issue full and partial refunds from the Drupal admin (from a completed payment).
- Restrict the BLIK create/status routes to users with order-update access.
- Dispatch `ImojePaymentEvent` (received / updated) so other modules can react.
- Keep the imoje service key and API token in gateway configuration; keep exported config out of public version control.
- Register the notification URL `<site>/payment/notify/{gateway_id}` in the imoje panel.
- Depend on `commerce_payment`; support Drupal `^10.3 || ^11`.
- Handle checkout, process payments, reconcile order state via the IPN.
