<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Klarna Payments integrates Klarna Payments with Drupal Commerce, using an off-site redirect flow and a push endpoint that re-fetches order status from Klarna's API.

---

Commerce Klarna Payments provides a Drupal Commerce payment gateway for Klarna Payments — the
customer completes payment via Klarna's off-site/hosted flow (an authorization token is captured by
Klarna's JS widget), and Klarna notifies the site of order status via a push endpoint. It depends on
Commerce Payment and Commerce Price.

The push endpoint is built correctly: rather than trusting the push payload, `PushEndpointController`
**re-fetches the order from Klarna's authenticated API** (`apiManager->getOrder()`) and acts only on
verified statuses (`AUTHORIZED`, `PART_CAPTURED`, `CAPTURED`). So a forged push cannot mark an order
paid — authenticity comes from the authenticated API call to Klarna, which is the right pattern for a
notification callback. When adopting, store the Klarna API credentials as secrets and confirm the
correct region/environment (test vs live). Standard Commerce concepts (orders, payments, capture)
apply.

---

- Accept Klarna Payments in Commerce.
- Use Klarna's off-site payment flow.
- Capture the Klarna authorization token.
- Handle Klarna push notifications.
- Re-fetch order status from Klarna's API.
- Act only on verified statuses.
- Reject forged pushes (API-verified).
- Depend on Commerce Payment and Price.
- Store Klarna credentials as secrets.
- Confirm region/environment.
- Create Commerce payments.
- Capture authorized Klarna payments.
- Integrate Klarna into checkout.
- Trust the authenticated API, not the push.
- Map Klarna status to payment state.
- Switch test vs live.
- Reconcile Klarna orders.
- Handle the redirect flow.
- Verify order authenticity server-side.
- Support Klarna billing.
