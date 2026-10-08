<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Mailer Lite Graph API Transport provides a transport to send emails using the Microsoft Graph API.

---

Symfony Mailer Lite Graph API Transport provides a mail transport that sends email via the Microsoft
Graph API — so Drupal (through Symfony Mailer Lite) can send mail through Microsoft 365 / Office 365 using
Graph API (OAuth-authenticated) instead of SMTP. It is configured at the
`symfony_mailer_lite_transport` collection. This suits organizations on Microsoft 365 that send mail via
Graph.

Use it to send Drupal mail through Microsoft Graph. The security-relevant point is credentials: it
authenticates to Graph with OAuth application credentials (client ID/secret, tenant) — store these as secrets
(not plaintext config), scope the app registration to mail-send only (least privilege), and requests use TLS
(Graph is HTTPS). It is a mail/developer feature with no content-access role. Configure the Graph transport
with the OAuth credentials.

---

- Send mail via Microsoft Graph API.
- Provide a Symfony Mailer Lite transport.
- Send through Microsoft 365.
- Authenticate with OAuth (Graph).
- Configure at the transport collection.
- Store Graph OAuth credentials as secrets.
- Scope the app registration least-privilege.
- Use TLS (Graph is HTTPS).
- Have no content-access role.
- Send mail via Graph instead of SMTP.
- Configure the Graph transport.
- Handle credentials securely.
- Use client ID/secret/tenant.
- Send Office 365 mail.
- Integrate Microsoft Graph mail.
- Configure OAuth for mail.
- Send transactional mail.
- Route mail via Graph.
- Handle Graph authentication.
- Configure the transport.
