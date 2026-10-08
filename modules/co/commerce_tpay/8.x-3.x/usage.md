<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Tpay integrates the Polish **Tpay** payment provider as an **offsite-redirect payment gateway** for
Drupal Commerce. Customers are redirected to Tpay to pay, and Tpay confirms the payment via an asynchronous
notification (IPN).

Use it to accept Tpay payments in a Polish-market Commerce store. It supports an optional on-site **bank
selection** step (a pluggable `CommerceTpayBankSelection` plugin type) before redirecting.
---
- Requires `commerce_payment`; enable with `ddev drush en commerce_tpay`.
- Add a payment gateway at `/admin/commerce/config/payment-gateways` and choose **Tpay Redirect**.
- Configure **Merchant ID** and **Merchant Secret** (from the Tpay panel → Settings → Notifications → Security).
- Optionally enable on-site bank selection and pick a bank-selection plugin.
- The notification URL is Commerce's standard `commerce_payment.notify` route for this gateway.
- Store the merchant secret as a secret; serve the site over HTTPS.
---
- Accept Tpay payments via offsite redirect.
- Confirm payments through Tpay's asynchronous notification (IPN).
- Verify the notification **checksum** via the bundled tpayLibs handler before recording payment.
- Bind the confirmation to the order via the signed **CRC** field (order id + currency).
- Create a completed Commerce payment on a valid notification.
- Deduplicate by remote transaction id so a repeated notify is ignored.
- Optionally show an on-site bank selection step.
- Extend bank selection via the `CommerceTpayBankSelection` plugin type.
- Dispatch a `TpayPaymentEvent` when a payment is received (for custom reactions).
- Redirect customers to a success or cancel page after payment.
- Log a "Wrong checksum" alert when verification fails.
- Support Polish bank transfer / BLIK flows offered by Tpay.
- Keep merchant credentials in gateway config (store as secrets).
- Use per-gateway notify URLs.
- Return `TRUE` to Tpay to acknowledge the notification.
- Test the full redirect + notify loop in Tpay sandbox before production.
