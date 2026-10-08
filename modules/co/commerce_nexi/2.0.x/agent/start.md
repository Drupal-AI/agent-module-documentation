<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Nexi (commerce_nexi) — agent index

**Off-site Drupal Commerce payment gateway for Nexi (XPay).**

- **Version:** 2.0.x  **Core:** ^9.3 || ^10 || ^11
- **Depends:** commerce, commerce_payment
- **Gateway:** `src/Plugin/Commerce/PaymentGateway/NexiGateway.php`; payment-method type `NexiCreditCard`.
- **Routes:** `commerce_nexi.checkout.return` (`/nexi-checkout/{commerce_order}/return`) and `.cancel` — both `_access: 'TRUE'`, `no_cache`. Controller = redirect layer only.
- **Crypto:** `CryptographicService` (MAC), `QueryHelper` builds the Nexi request; `NexiValidNotify` event on verified notify.
- **Security:** the `_access: 'TRUE'` return/cancel routes are session-less browser landings; payment validity is established by `onReturn()` re-fetching the payment from Nexi (`getRemotePayment`) and verifying server-side — the returned query string is not trusted. No client-set amount honored.

See [configure/gateway.md](configure/gateway.md).
