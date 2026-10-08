<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Barion Payment provides a Barion payment gateway for Drupal Commerce, confirming payment status by querying Barion's API rather than trusting the callback.

---

Commerce Barion Payment provides a Drupal Commerce payment gateway for Barion (a European payment
provider). The customer pays via Barion's flow, and Barion notifies the site (`onNotify`) with a
`paymentId`; the module then calls Barion's authenticated API (`GetPaymentState`) to fetch the real
payment state rather than trusting the notification payload. It depends on Commerce and Commerce Payment.

This API-verification model is the correct posture: because the payment status is fetched server-to-server
from Barion (using the merchant's API key), a forged notification cannot mark an order paid — the module
acts on the authoritative state from Barion. When adopting, store the Barion API key/POS key as secrets
and confirm the environment (test vs live). Standard Commerce concepts (orders, payments) apply.

---

- Accept Barion payments in Commerce.
- Confirm payment state via Barion's API.
- Query GetPaymentState on notify.
- Reject forged notifications (API-verified).
- Depend on Commerce and Commerce Payment.
- Store the Barion API key as a secret.
- Confirm test vs live environment.
- Create Commerce payments.
- Handle Barion notifications.
- Trust the authenticated API, not the callback.
- Map Barion state to payment.
- Integrate Barion into checkout.
- Reconcile Barion payments.
- Verify order status server-side.
- Switch environments.
- Process European payments.
- Fetch authoritative payment state.
- Handle the payment flow.
- Store POS keys as secrets.
- Support Barion billing.
