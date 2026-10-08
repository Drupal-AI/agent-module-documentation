<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Paynow integrates the Paynow (mBank) payment gateway (Poland) with Drupal Commerce.

---

Commerce Paynow provides Commerce integration for Paynow (mBank) — a payment gateway for Poland — the shopper pays via Paynow and Paynow posts a webhook.

Security: the webhook controller delegates to a NotificationProcessor that constructs the Paynow SDK `Notification($signatureKey, $payload, $headers)`, which verifies the `Signature` header (HMAC) and throws on mismatch before the payment state is changed — a correct, defensive pattern. Store the Paynow (mBank) API credentials securely (env-backed), never committed. Depends on `commerce_payment`; supports Drupal per ^10 || ^11.

---

- Integrate the Paynow (mBank) gateway.
- Serve Poland.
- Redirect/charge via the provider.
- Complete the order after payment.
- the webhook controller delegates to a NotificationProcessor that constructs the Paynow SDK `Notification($signatureKey, $payload, $headers)`, which verifies the `Signature` header (HMAC) and throws on mismatch before the payment state is changed — a correct, defensive pattern.
- Use Drupal Commerce payment.
- Store credentials securely (env-backed).
- Never commit credentials.
- Depend on `commerce_payment`.
- Support ^10 || ^11.
- Handle checkout.
- Process payments.
- Confirm the payment.
- Handle notifications.
- Support Commerce.
- Integrate Paynow (mBank).
- Charge customers.
- Reconcile orders.
