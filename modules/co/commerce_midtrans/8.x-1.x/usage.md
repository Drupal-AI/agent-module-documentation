<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Midtrans integrates the Midtrans payment gateway (Indonesia) with Drupal Commerce.

---

Commerce Midtrans provides Commerce integration for Midtrans — a payment gateway for Indonesia — the shopper pays via Midtrans (Snap) and Midtrans posts a notification.

Security: the notify route is public (`_access: 'TRUE'`) but the Midtrans SDK `Notification` object re-fetches the authoritative transaction status SERVER-SIDE from Midtrans (`Transaction::status()` with the server key) rather than trusting the POST body — so forged notifications cannot complete an unpaid order. Store the Midtrans API credentials securely (env-backed), never committed. Depends on `commerce_payment`; supports Drupal per ^10 || ^11.

---

- Integrate the Midtrans gateway.
- Serve Indonesia.
- Redirect/charge via the provider.
- Complete the order after payment.
- the notify route is public (`_access: 'TRUE'`) but the Midtrans SDK `Notification` object re-fetches the authoritative transaction status SERVER-SIDE from Midtrans (`Transaction::status()` with the server key) rather than trusting the POST body — so forged notifications cannot complete an unpaid order.
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
- Integrate Midtrans.
- Charge customers.
- Reconcile orders.
