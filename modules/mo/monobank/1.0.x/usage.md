<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Monobank provides payments via the Monobank acquiring API for a Drupal store.

---

Monobank provides payment integration with Monobank (the Ukrainian bank's acquiring API) — creating
invoices and accepting payments for a Drupal store (it integrates with a basket/order system). It is
configured at `monobank.settings`, provides its own permissions, and is in the Online store package.

The status callback route `/monobank/status` (`Pages::pages('status')`, permission `access content`) receives
Monobank's payment status POST, marks the payment paid (`paytime`, status `success`) and calls the basket's
`paymentFinish()` to fulfil the order; the user-facing `payment_result` page checks the payment via server-side
`getStatus()`. Operate over HTTPS and store the Monobank token as a secret.

---

- Accept Monobank payments.
- Create Monobank invoices.
- Integrate with a basket/order system.
- Configure at monobank.settings.
- Provide its own permissions.
- Confirm payment via server-side getStatus().
- Operate over HTTPS.
- Store the Monobank token as a secret.
- Receive payment status callbacks at /monobank/status.
- Handle acquiring.
