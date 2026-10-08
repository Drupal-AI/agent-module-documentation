<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Alphabank provides an Alpha Bank (Greece) off-site redirect payment gateway for Drupal Commerce.

---

Commerce Alphabank **provides an Alpha Bank (Greece) / Cardlink off-site redirect payment gateway**
for Drupal Commerce. At checkout the customer is auto-POSTed to the bank's hosted card page
(`postUrl`), pays there, and the bank returns the result to the module's callback
(`/commerce_alphabank_redirect/callback`), which records the Commerce payment. No card data is
stored on the Drupal side. It depends on Commerce and Commerce Payment.

Use it to accept Alpha Bank card payments. Its callback verification is sound: the return
handler computes a **sha256 digest over the response fields concatenated with the merchant's
`shared_secret`** and records a **completed** payment only when the received `digest` matches —
so an attacker who doesn't know the secret cannot forge a "paid" callback. On a digest mismatch
it records a non-fulfilling `"Unvalidated"` payment and logs a failure (Commerce treats only
`completed` payments as paid), and only a secret-valid `CAPTURED`/`AUTHORIZED` response creates a
completed payment. The recorded amount is the server-side order balance, not the callback amount,
and the `shared_secret` is never sent to the browser. Security essentials: keep the
**`shared_secret` genuinely secret** (it is the whole basis of trust) and serve the callback over
HTTPS. Configure the merchant ID, currency, post/return URLs and shared secret on the gateway;
optionally enable the **IRIS** pay method (which also builds a DIAS RF payment code).

---

- Provide an Alpha Bank / Cardlink redirect gateway (plugin `alphabank_redirect`).
- Auto-POST the customer to the bank's hosted page (`postUrl`).
- Record the payment on the bank's return callback.
- Depend on Commerce + Commerce Payment.
- Verify the callback digest, keyed with the merchant `shared_secret`.
- Record a completed payment only on a secret-valid CAPTURED/AUTHORIZED response.
- Record a non-fulfilling 'Unvalidated' payment on digest mismatch (no forgery without the secret).
- Credit the server-side order balance, not the callback-supplied amount.
- Never send the shared_secret to the browser (only the derived digest).
- Support an optional IRIS pay method with a DIAS RF payment code.
- Let modules alter the IRIS billing phone field via an alter hook.
- Keep the shared_secret secret and serve the callback over HTTPS.
- Configure merchant ID, currency, confirm/cancel URLs, post URL and shared secret.
- Handle Alpha Bank card payments end to end.
