<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zoho Mail sends email using the Zoho third party API.

---

Zoho Mail **sends site email via the Zoho Mail API** — routing Drupal's outbound mail through Zoho's
transactional email service (instead of local SMTP), integrated via the Mail System module. It depends on the
Mail System module, provides its own permissions, in the Mail package.

Use it to send mail through Zoho. It is a mail/integration feature. Security/data handling: it authenticates with
**Zoho API credentials** (store as a **secret** — env/Key — over HTTPS; the credential can send mail as your
domain) and **email content/recipients pass through Zoho** (external — a third-party mail provider processes your
outbound mail). It has no access-control role beyond its permission. Configure the Zoho Mail credentials.

---

- Send email via the Zoho Mail API.
- Route outbound mail through Zoho.
- Integrate with Mail System.
- Depend on the Mail System module.
- Provide its own permissions.
- Use a transactional email service.
- Authenticate with Zoho API credentials.
- Store the credentials as a secret over HTTPS.
- Note mail content/recipients pass through Zoho.
- Have no access-control role beyond permission.
- Configure the Zoho credentials.
- Handle Zoho mail.
- Send email.
- Configure the client.
- Route mail.
- Handle the integration.
- Deliver mail.
- Send mail.
- Secure the credentials.
- Provide Zoho mail sending.
