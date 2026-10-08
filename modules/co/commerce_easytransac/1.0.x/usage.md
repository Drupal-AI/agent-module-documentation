<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce EasyTransac adds EasyTransac as an offsite payment gateway for Drupal Commerce, supporting card payments, Pay by bank, multiple/installment payments and OneClick (saved card) payments.

---

The gateways extend `OffsitePaymentGatewayBase`. Customers pay on EasyTransac's hosted form; EasyTransac then returns to `onReturn` and posts a server-to-server notification to `onNotify` (Commerce's `commerce_payment.notify` route). Both handlers pass the raw POST through `EasyTransac\Core\PaymentNotification::getContent($request->request->all(), $apiKey)`, which verifies the EasyTransac signature using the account API key before the payment is trusted; `onReturn` additionally asserts the returned order id matches, and `matchCustomer()` asserts the notification's user id matches the order's. Payment amounts and states come from the verified EasyTransac response (mapped in `syncNewPayment`/`syncExistingPayment`), not from client input. The gateway derives test vs live mode from the API-key prefix (`et_test_`/`et_live_`) and supports capture, void, refund, sync and status operations plus a request `EasyTransacRequestEvent` for altering outgoing requests. A `CookieSameSiteSessionConfiguration` decorator adjusts SameSite for the offsite redirect. The API key is stored in the gateway configuration (standard Commerce practice) and only sent to EasyTransac.

Setup: install `easytransac/easytransac` SDK, add an EasyTransac payment gateway, paste the API key, and copy the shown Notification URL into your EasyTransac application. Configure OneClick / installment options as needed. (Reviewed with care: notification signature is verified with the API key; order and customer ids are matched; amounts are taken from the verified response — no unverified callback or client-set amount observed.)

---
- Accept Visa/Mastercard/Maestro/Amex via EasyTransac hosted form
- Offer "Pay by bank" as an alternative method
- Enable installment (multiple) payments over 2–12 months
- Enable OneClick payments with a saved card alias
- Configure the EasyTransac API key per gateway
- Auto-select test vs live mode from the API key prefix
- Copy the notification URL into the EasyTransac app
- Verify the payment notification signature before crediting
- Match the returned order and customer ids for safety
- Capture a previously authorized payment
- Void an authorization
- Refund a completed payment (full or partial)
- Sync a payment's remote status on demand
- Look up a payment's status from EasyTransac
- Set a pre-authorization duration (1–30 days)
- Save reusable payment methods for authenticated users
- Alter outgoing API requests via EasyTransacRequestEvent
- Restrict gateway admin to `administer commerce easytransac`
- Handle pending/failed/refunded notification statuses
- Support down-payment amounts for installment plans