<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CCBill notify verification

**Redirect out** (`CCBillPaymentForm::getData`): builds FlexForm GET params incl. `initialPrice = number_format(order total)`, `currencyCode` (numeric map), `email`, billing fields, and `formDigest = md5(initialPrice . initialPeriod . currencyCode . salt)`.

**Post-back** (`CCBill::onNotify(Request)`):
1. `validateRequest()`:
   - if `validate_ip` (default TRUE): `isIpRangeValid(getClientIp())` against `SECURE_IP_RANGES` (four 64.38.x ranges).
   - `isMd5Valid($request['X-formDigest'], subscriptionInitialPrice, initialPeriod, subscriptionCurrencyCode)` → recompute `md5(price . period . currency . salt)` and compare with `===`.
2. On `eventType == NewSaleSuccess` and no existing payment for `transactionId`: create a `completed` `commerce_payment` with `amount = Price(accountingInitialPrice, accountingCurrency)`, set order state `completed`, dispatch `CCBillPaymentEvent`.

**Observations (file:line):**
- `CCBill.php:198,205-206` — the digest is validated over `subscriptionInitialPrice`/`initialPeriod`/`subscriptionCurrencyCode`, but `:174` records the amount from `accountingInitialPrice`/`accountingCurrency`, which are **not** part of the signed digest (amount used ≠ amount signed).
- `:194` IP validation is optional (can be disabled in config).
- Digest is MD5-based (CCBill protocol) and compared with `===`.
