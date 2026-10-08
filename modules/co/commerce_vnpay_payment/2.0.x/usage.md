<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce VNPay integrates the Vietnamese **VNPay** payment provider as an **offsite-redirect payment gateway**
for Drupal Commerce. The customer is redirected to VNPay with an HMAC-SHA512 signed request and returns to the
site after paying.

Use it to accept VNPay payments in a Vietnam-market Commerce store. Configure the VNPay endpoint URL,
`vnp_TmnCode`, and `vnp_HashSecret` on the gateway.
---
- Requires `commerce_payment`; enable with `ddev drush en commerce_vnpay_payment`.
- Add a payment gateway at `/admin/commerce/config/payment-gateways` and choose **VNPay**.
- Set **vnp_Url** (sandbox/production), **vnp_TmnCode**, and **vnp_HashSecret**.
- The outbound payment URL is signed with **HMAC-SHA512** over the sorted parameters.
- The return handler reads `vnp_ResponseCode` / `vnp_TransactionStatus` from the query on the checkout return.
- Store `vnp_HashSecret` as a secret; serve the site over HTTPS.
---
- Accept VNPay payments via offsite redirect.
- Build a signed (HMAC-SHA512) request to VNPay's payment page.
- Pass order id, amount (x100), currency, and billing details to VNPay.
- Return the customer to the Commerce checkout return step.
- Create a Commerce payment (authorization) on a success response code.
- Bind the created payment amount to the order total.
- Support VNPay sandbox and production endpoints.
- Include billing name/address/email when a billing profile exists.
- Set a 15-minute payment expiry (`vnp_ExpireDate`).
- Map VNPay response codes to messages.
- Cancel gracefully when the customer aborts.
- Localize the VNPay locale from the current language.
- Use for Vietnamese-market checkout.
- Configure credentials per gateway (store as secrets).
- Test the redirect loop in VNPay sandbox first.
- SECURITY: verify the return `vnp_SecureHash` before trusting the result (see agent note).
