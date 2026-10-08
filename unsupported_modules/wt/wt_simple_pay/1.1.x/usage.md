<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The payment engine of the WT Commerce Suite (Viva/PayPal).

---

WT Simple Pay is the core financial engine for the WT Commerce Suite in Drupal — handling payments (via Viva and PayPal) for the suite's booking modules, with a token-gated webhook that records payment events.

The webhook `/wtpay/webhook` is protected by a configured shared-secret `token` (rejected with 401 on mismatch); the payment provider keys are admin-configured (store securely, env-backed). Depends on core `node`; supports Drupal 11. Project `wt_commerce`.

---

- Process WT Commerce payments.
- Support Viva and PayPal.
- Underpin the booking modules.
- Record payment events.
- Gate the webhook by a token.
- Store provider keys securely.
- Depend on core `node`.
- Support Drupal 11.
- Aid e-commerce.
- Handle payments.
- Take payments.
- Confirm orders
- Support Drupal.
- Support Drupal.
- Support Drupal.
