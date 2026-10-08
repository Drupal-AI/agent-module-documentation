<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce CCBill provides an off-site Drupal Commerce payment gateway that redirects buyers to a CCBill FlexForm and records payments from CCBill's background post-back.

---
The offsite form (`CCBillPaymentForm`) GET-redirects to the FlexForm URL (`.../wap-frontflex/flexforms/{flex_form_id}`) with the order total, currency code, email, billing address and a `formDigest` = `md5(initialPrice . initialPeriod . currencyCode . salt)`. The gateway's `onNotify()` handles CCBill's post-back: it validates the request (optional client-IP check against CCBill's published ranges, plus an MD5 digest check) and, on `NewSaleSuccess`, creates a completed `commerce_payment` and sets the order to completed.

Security observations to report: notify verification exists but the validated MD5 digest covers `subscriptionInitialPrice`/`initialPeriod`/`subscriptionCurrencyCode` (`CCBill.php:198,205-206`) while the payment amount actually recorded is taken from the un-signed request params `accountingInitialPrice`/`accountingCurrency` (`CCBill.php:174`) — the amount used is not the amount covered by the digest. The IP check is optional (config `validate_ip`, default on). The `salt` and account numbers are stored in gateway config. Setup: enter client account/subaccount, FlexForm ID and salt at the gateway, keep IP validation enabled, and configure the CCBill background post-back URL to the Commerce notify endpoint.
---
- Add a CCBill off-site payment gateway.
- Redirect buyers to a CCBill FlexForm.
- Record payments from CCBill's post-back.
- Verify notifications by MD5 form digest.
- Restrict notifications to CCBill IP ranges.
- Configure client account and subaccount numbers.
- Set the FlexForm ID and salt.
- Toggle IP validation on or off.
- Support sandbox and live modes.
- Map order currency to CCBill numeric codes.
- Pass billing name/address to CCBill.
- Dispatch a payment-received event on success.
- Complete the order on `NewSaleSuccess`.
- Store the shared salt securely.
- Reconcile transactions by remote transaction ID.
- Review the accountingInitialPrice vs digest mismatch before production.
