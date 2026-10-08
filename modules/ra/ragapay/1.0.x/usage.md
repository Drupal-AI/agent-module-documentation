<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RagaPay

Integrates the RagaPay payment gateway with Drupal Commerce as an off-site redirect method, plus a notification (webhook) endpoint RagaPay calls to report the payment result.

- Off-site payment gateway plugin `ragapay_offsite`.
- Redirects the customer to RagaPay with a signed hash.
- Receives a server-to-server notification to finalize the order.
- Maps RagaPay statuses to Commerce payment states.

---

# Installing & configuring

- Require and enable with Commerce payment/price (`drush en ragapay`).
- Add a "RagaPay (Off-site redirect)" payment gateway in Commerce.
- Enter the merchant key and password (shared secret) in the gateway config.
- The notification URL (`/ragapay/notification`) is shown read-only to register in your RagaPay account.
- The outbound redirect hash is built by `HashBuilder` from order id, price, currency, label, and password.

---

# Usage & behaviour

- At checkout `RagaPayOffsiteForm` posts the customer to RagaPay with a secure hash.
- `onReturn()` creates a `new`-state payment for the order balance.
- RagaPay then POSTs a notification to `/ragapay/notification`.
- `NotificationController::__invoke` parses the body and calls `RagaPayManager::updateOrder`.
- `updateOrder` loads the order and the ragapay payment, then sets state from the posted `status`.
- `status=success` maps to the `completed` payment state; `fail`→canceled; `waiting`→pending.
- The notification route requirement is `_permission: 'access content'`.
- `HashBuilder::generateSecureHash` uses `sha1(md5(strtoupper(...)))`.
- The gateway stores `merchant_key` and `password` in gateway configuration.
- `PriceFormatter` normalizes the amount for hashing.
- Statuses are modelled by the `PaymentStatus` enum.
- Response field names come from the `ResponseFields` enum.
- The module targets Commerce on Drupal 10 or 11.
- Uninstalling removes the gateway plugin and notification route.
- Merchant credentials should be treated as secrets.
