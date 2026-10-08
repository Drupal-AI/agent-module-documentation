<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Resend API sends email via the Resend API.

---

Resend API (resend_api) **sends email through Resend** — integrating the Resend email-delivery API as a Drupal
mail backend (via Mail System). It depends on the Mail System module.

Use it to send transactional email via Resend. It is a mail/integration feature. Security/data handling: it **sends
email content and recipient addresses (PII) to the Resend API** (egress) and authenticates with a **Resend API key**
(store as a secret — env/Key — never commit; over HTTPS). It has no access-control role. Configure the Resend API
key.

---

- Send email via Resend.
- Integrate the Resend API.
- Act as a mail backend.
- Depend on the Mail System module.
- Serve mail/integration.
- Deliver transactional email.
- Send content + recipient PII to Resend (egress).
- Store the Resend API key as a secret (env/Key, never commit, HTTPS).
- Have no access-control role.
- Configure the Resend API key.
- Handle Resend mail.
- Send email.
- Configure the client.
- Deliver mail.
- Handle the integration.
- Send messages.
- Configure Mail System.
- Handle the sending.
- Secure the key.
- Provide Resend email.
