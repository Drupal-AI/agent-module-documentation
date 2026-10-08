<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Valitor (commerce_valitor) — agent index
**Commerce payment gateway for the Valitor platform with tokenised cards and 3-D Secure verification.**

- **version:** 2.0.x
- **core:** ^10.1 || ^11 || ^12
- **depends on:** commerce:commerce_payment
- **configure:** `commerce_payment.configuration`
- **plugins:** `Valitor` gateway (+ `ValitorMock`); API via `ValitorPayApi`; add/edit/refund plugin forms.
- **routes (`_access: 'TRUE'`):** `/valitor/{commerce_payment_gateway}/verify` (POST, 3DS card verify), `/valitor/3ds` (GET redirect page), `/valitor/webhook` (POST/OPTIONS, renders 3DS result).
- **Security (reviewed sound):** capture uses order-derived `$payment->getAmount()`, not the client amount; the webhook renders 3DS status/error markup only (no money movement on the open route). `_access: TRUE` routes are browser/processor callbacks in the checkout flow.

See [configure/gateway.md](configure/gateway.md)
