<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Mailer MS Graph sends email via the Microsoft Graph API from Symfony Mailer.

---

Symfony Mailer MS Graph provides a Microsoft Graph email transport for Symfony Mailer — sending mail through Microsoft 365 via the Graph API, supporting both application and delegated authentication, so Drupal can send from Microsoft 365 mailboxes using modern OAuth2 instead of SMTP basic auth.

OAuth2 credentials are stored via the Key module (env-backed); administration is gated by `administer symfony mailer ms graph`. Depends on `symfony_mailer` and `key`; supports Drupal 10.1+, 11, and 12.

---

- Send email via Microsoft Graph.
- Provide a Symfony Mailer transport.
- Support application auth.
- Support delegated auth.
- Send from Microsoft 365 mailboxes.
- Use OAuth2 instead of SMTP basic auth.
- Store credentials via Key (env-backed).
- Gate admin with `administer symfony mailer ms graph`.
- Depend on `symfony_mailer` and `key`.
- Support Drupal 10.1+, 11, and 12.
- Integrate Microsoft 365 mail.
- Configure the transport.
- Support modern email auth
- Keep credentials secure
- Send transactional mail.
- Handle Graph API.
- Integrate Microsoft.
- Deliver via Graph
