<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bambora integrates the Bambora payment gateway with Commerce, confirming payments via server-side API calls.

---

Bambora Payment System provides Drupal Commerce integration with the Bambora (Worldline) payment gateway — including Interac Online and card checkout, redirecting customers to pay and returning to complete the order.

Security: the Interac return endpoints (`/checkout/order/interac/complete` etc.) are anonymous by design, but completion is gated by a **server-side API call** (`continuePayment()`) to Bambora with merchant credentials — the payment is confirmed against Bambora's API (not the request params), and the completed amount uses `$order->getTotalPrice()` (server-side), so forged callbacks cannot mark an order paid (a defensive positive). Bambora API credentials should be stored securely (env-backed). Depends on Commerce `commerce_payment` and `commerce_order`; supports Drupal 9.3+, 10, and 11.

---

- Integrate the Bambora gateway.
- Support Interac Online.
- Support card checkout.
- Redirect customers to pay.
- Complete orders on return.
- Confirm payment via server-side `continuePayment()`.
- Use merchant credentials for confirmation.
- Not trust request params for completion.
- Use the server-side order total.
- Reject forged callbacks.
- Store API credentials securely (env-backed).
- Depend on Commerce `commerce_payment`/`commerce_order`.
- Support Drupal 9.3+, 10, and 11.
- Serve Canadian payments.
- Verify payments securely.
- Handle the redirect flow
- Process refunds/voids
- Confirm via API
