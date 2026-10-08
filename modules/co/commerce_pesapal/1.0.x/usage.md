<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Pesapal adds a Pesapal payment gateway that verifies IPN status server-side.

---

Commerce Pesapal integrates the Pesapal payment gateway (popular in East Africa) with Drupal Commerce as an off-site redirect gateway. After payment, Pesapal calls an IPN endpoint (`/payment/pesapal/ipn`) and the customer is returned to the site.

The IPN handler does **not** trust the request's status: it re-fetches the real transaction status from Pesapal's API server-side (OAuth HMAC-SHA1 signed) via `queryPaymentStatus()`, fulfils only on a re-fetched `COMPLETED`, records the server-side order total (not a request amount), and de-duplicates by remote transaction id. Depends on Commerce `commerce_payment`, `commerce_order`, and `commerce_price`; supports Drupal 10 and 11.

---

- Integrate the Pesapal gateway.
- Provide an off-site redirect gateway.
- Receive payment via an IPN endpoint.
- Re-fetch transaction status server-side.
- Sign API calls with OAuth HMAC-SHA1.
- Fulfil only on re-fetched COMPLETED.
- Use the server-side order total.
- Dedup by remote transaction id.
- Depend on Commerce payment/order/price.
- Support Drupal 10 and 11.
- Return customers after payment.
- Verify payments correctly.
- Target East African payments.
- Query Pesapal for real status.
- Avoid trusting request status.
- Complete orders safely.
- Handle the redirect flow.
