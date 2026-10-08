<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Konnect integrates the Konnect payment gateway (Tunisia) with Drupal Commerce.

---

Commerce Konnect provides Commerce integration for Konnect — a payment gateway for Tunisia — the shopper pays via Konnect (Bank Cards, E-Dinar, Flouci) and returns with a payment id.

Security: `onReturn()` re-fetches the transaction SERVER-SIDE from Konnect's API (Basic auth) by `payment_id`, rejects id-switching (`response.orderId` must equal the order id), completes only when the API status is `CAPTURED`, and uses `$order->getTotalPrice()` — the strongest pattern in the wave. Store the Konnect API credentials securely (env-backed), never committed. Depends on `commerce_payment`; supports Drupal per ^10 || ^11.

---

- Integrate the Konnect gateway.
- Serve Tunisia.
- Redirect/charge via the provider.
- Complete the order after payment.
- `onReturn()` re-fetches the transaction SERVER-SIDE from Konnect's API (Basic auth) by `payment_id`, rejects id-switching (`response.orderId` must equal the order id), and completes only when the API status is `CAPTURED`.
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
- Integrate Konnect.
- Charge customers.
- Reconcile orders.
