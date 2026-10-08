<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Moyasar integrates the Moyasar payment gateway (Saudi Arabia) with Drupal Commerce.

---

Commerce Moyasar provides Commerce integration for Moyasar — a payment gateway for Saudi Arabia. The shopper pays through Moyasar's embedded payment form (credit card, Apple Pay, STC Pay) and returns to the site with a payment id.

Confirmation is server-side: `onReturn()` re-fetches the payment from Moyasar's API (HTTP Basic auth with the secret key) by id and completes the order only when Moyasar's API reports a `paid`, `authorized`, or `captured` status. This 2.0.x branch adds reusing saved payment methods (tokenized cards). Store the Moyasar secret API key securely (environment variable / settings override), never committed to version control. Depends on `commerce_payment`; supports Drupal `^9.3 || ^10 || ^11`, PHP `>=8.0`.

---

- Integrate the Moyasar gateway into Drupal Commerce.
- Serve Saudi Arabia (SAR); accept credit card, Apple Pay, STC Pay.
- Render Moyasar's embedded payment form on the checkout page.
- Complete the order after payment.
- `onReturn()` re-fetches the payment server-side from Moyasar's API (Basic auth) by id and completes only on the API status (`paid`/`authorized`/`captured`).
- Charge the order total (server-side) for saved-token payments.
- Capture, void, and refund payments from the payment terminal.
- Reuse saved payment methods (tokenized cards) when enabled.
- Register the Mada card type.
- Store the secret API key securely (env / settings override).
- Never commit credentials.
- Depend on `commerce_payment`.
- Support `^9.3 || ^10 || ^11`, PHP `>=8.0`.
