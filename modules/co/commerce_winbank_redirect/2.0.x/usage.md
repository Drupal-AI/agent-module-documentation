<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Winbank Redirect provides the Winbank payment gateway.

---

Commerce Winbank (Redirect) provides a **Winbank (Piraeus Bank) redirect payment gateway for Drupal
Commerce** — accepting card payments through Winbank's hosted (offsite-redirect) checkout, common in Greece. It
depends on Commerce and Commerce Payment, in the Commerce package.

Use it to accept Winbank payments. It is an e-commerce/payment feature and its callback handling is done
**correctly**: the callback route is public (`_access: 'TRUE'`, as the bank posts the result), but the controller
**verifies the response signature** — it recomputes an **HMAC-SHA256 `HashKey`** (`hash_hmac('sha256',
concatValues, TranTicket)`) and rejects the callback if it doesn't match the received `HashKey`, so a forged
callback can't mark an order paid. Store the Winbank **merchant credentials** as secrets over HTTPS. (Minor: the
hash comparison uses `!==` rather than `hash_equals`, and the request password uses the bank-required MD5 format
— both dictated by/consistent with the gateway protocol.) It has no access-control role. Configure the Winbank
credentials.

---

- Accept Winbank card payments.
- Use the offsite-redirect flow.
- Serve Greek payments.
- Depend on Commerce and Commerce Payment.
- VERIFY the callback HMAC-SHA256 HashKey.
- Reject forged callbacks.
- Recompute hash_hmac('sha256', values, TranTicket).
- Store merchant credentials as secrets over HTTPS.
- Note the MD5 password is the bank's required format.
- Prefer hash_equals over !== (minor).
- Have no access-control role.
- Configure the Winbank credentials.
- Handle Winbank payments.
- Verify payments.
- Configure the gateway.
- Process payments.
- Handle the callback.
- Take payments.
- Secure the credentials.
- Provide Winbank payment.
