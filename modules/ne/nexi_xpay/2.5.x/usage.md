<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nexi XPay integrates the Nexi XPay payment gateway with a transaction entity and token-verified notify.

---

Nexi XPay provides Nexi XPay payment integration for Drupal: services, a `nexi_xpay_transaction` entity, payment start/return/notify endpoints, and a plugin system for extending Nexi integrations. Customers are sent to Nexi to pay and returned to the site.

Security: the server-to-server notify endpoint `/nexi-xpay/notify/{transaction}/{token}` is gated by a per-transaction 256-bit token (`^[a-f0-9]{64}$`) verified with `hash_equals()` (a NotifyTokenAccessCheck), so forged notifications are rejected — a defensive positive. Nexi API credentials should be env-backed. Permissions: `administer nexi xpay`, `view nexi xpay transactions`. Depends on core `field`/`options`/`system`/`user`; requires Drupal 11.

---

- Integrate Nexi XPay payments.
- Provide a transaction entity.
- Expose start/return/notify endpoints.
- Offer a plugin system.
- Send customers to Nexi to pay.
- Gate notify with a 256-bit per-transaction token.
- Verify the token with `hash_equals()`.
- Reject forged notifications.
- Store Nexi credentials env-backed.
- Gate admin with `administer nexi xpay`.
- Gate viewing with `view nexi xpay transactions`.
- Depend on core `field`/`options`/`user`.
- Require Drupal 11.
- Support Italian payments.
- Handle the redirect flow.
- Manage transactions.
- Verify payments securely
- Extend via plugins
