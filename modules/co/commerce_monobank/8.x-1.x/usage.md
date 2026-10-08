<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Monobank implements the Monobank payment gateway.

---

Commerce Monobank provides a **Monobank payment gateway for Drupal Commerce** — accepting payments through
Monobank's acquiring (offsite redirect / invoice) flow, popular in Ukraine. It depends on Commerce Payment, in
the commerce package.

Use it to accept Monobank payments. It is an e-commerce/payment feature and its verification follows the
**authoritative pattern**: rather than trusting an unverified callback, it queries Monobank's **server-side
status API** (`api/merchant/invoice/status?invoiceId=…`) with the merchant token to confirm the invoice's real
state before completing the payment (there is no unverified public callback route — it uses Commerce's flow +
the status API). Store the Monobank **X-Token** securely (note: this release stores it in module config rather
than via the Key module — restrict config access / avoid committing it, or manage the secret out of band), over
HTTPS. Alpha release — verify the flow for your version. Configure the Monobank credentials.

---

- Accept Monobank payments.
- Use the invoice/offsite flow.
- Serve Ukrainian payments.
- Depend on Commerce Payment.
- CONFIRM via Monobank's server-side status API.
- Query api/merchant/invoice/status with the token.
- Not trust an unverified callback.
- Store the X-Token securely (config — restrict/avoid committing).
- Use HTTPS.
- Verify the flow for your (alpha) version.
- Have no access-control role.
- Configure the Monobank credentials.
- Handle Monobank payments.
- Verify payments.
- Configure the gateway.
- Process payments.
- Handle the integration.
- Take payments.
- Secure the token.
- Provide Monobank payment.
