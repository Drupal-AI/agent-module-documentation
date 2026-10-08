<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Moneris Checkout provides integration with Moneris Checkout.

---

Commerce Moneris Checkout provides a **Drupal Commerce payment gateway for Moneris Checkout (MCO)** —
Moneris's hosted checkout — capturing card payments through Moneris. It depends on Commerce Payment, in the
Commerce (contrib) package.

Use it to accept Moneris payments. Its payment trust boundary is **implemented correctly** (verified): on
return, `onReturn()` checks the response code, then **fetches the Moneris receipt server-side**
(`getReceipt($ticket)` — a server-to-Moneris API call) and **verifies the receipt's `order_no` matches the
order's stored MCO data** before recording the payment — so the confirmation is authenticated against Moneris
rather than trusting the returning request's fields, and a forged/mismatched return is rejected. Handle the
Moneris **API token/store credentials** as secrets, use HTTPS. It has no access-control role. Configure the
Moneris credentials.

---

- Accept Moneris Checkout payments.
- Use Moneris hosted checkout.
- Fetch the Moneris receipt server-side.
- Verify the receipt order_no matches the order.
- Reject forged/mismatched returns.
- Check the response code.
- Authenticate against Moneris (not request fields).
- Store Moneris credentials as secrets.
- Use HTTPS.
- Depend on Commerce Payment.
- Have no access-control role.
- Configure the Moneris credentials.
- Handle Moneris payments.
- Verify payments.
- Configure the gateway.
- Confirm via receipt.
- Handle the return.
- Process payments.
- Secure the credentials.
- Provide Moneris payment.
