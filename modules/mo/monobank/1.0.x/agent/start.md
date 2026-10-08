<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Monobank — agent index

Payments via **Monobank** (Ukrainian acquiring API) — create invoices, accept payments (basket/order
integration). Config at `monobank.settings`; provides permissions. Version **1.0.2**. Core `^9||^10||^11`.

Status callback route `/monobank/status` (`_permission: access content`) marks a payment `success` and calls
the basket's `paymentFinish()`; the `payment_result` page checks status via server-side `getStatus()`. Operate
over HTTPS; store the token as a secret.
