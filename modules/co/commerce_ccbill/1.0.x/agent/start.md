<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce CCBill (commerce_ccbill) — agent index

**Off-site CCBill FlexForm gateway with IP + MD5-digest notify verification.**

- **Version:** 1.0.x · **Core:** ^8.8 || ^9 || ^10 · **Depends:** commerce, commerce_payment
- **Plugin:** `Plugin/Commerce/PaymentGateway/CCBill` (id `ccbill`); offsite form `CCBillPaymentForm` (GET redirect to FlexForm).
- **Config:** client account/subaccount, `flex_form_id`, `salt`, `validate_ip`.

**Security:** `onNotify()` verifies via optional CCBill-IP-range check + `md5(price.period.currency.salt)` digest. Observation: digest signs `subscriptionInitialPrice`/`subscriptionCurrencyCode` (`CCBill.php:198,205`) but the recorded payment amount comes from unsigned `accountingInitialPrice`/`accountingCurrency` (`:174`). See [api/notify.md](api/notify.md).
