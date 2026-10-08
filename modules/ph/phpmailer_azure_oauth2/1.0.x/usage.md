<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PHPMailer Azure OAuth2 adds Entra ID OAuth2 (XOAUTH2) auth for PHPMailer SMTP sending.

---

PHPMailer Azure OAuth2 adds Microsoft Entra ID (Azure AD) OAuth2 / XOAUTH2 authentication for PHPMailer SMTP — so Drupal can send email through Microsoft 365 / Outlook SMTP using modern OAuth2 token authentication instead of basic auth (which Microsoft is deprecating). It builds on PHPMailer SMTP.

OAuth2 client credentials are stored via the Key module (env-backed); administration is gated by `administer phpmailer azure oauth2 settings`. Depends on `phpmailer_smtp` and `key`; supports Drupal 10.3+, 11, and 12.

---

- Add Entra ID OAuth2 for PHPMailer.
- Use XOAUTH2 SMTP auth.
- Send via Microsoft 365 SMTP.
- Replace deprecated basic auth.
- Build on PHPMailer SMTP.
- Store credentials via Key (env-backed).
- Gate admin with `administer phpmailer azure oauth2 settings`.
- Depend on `phpmailer_smtp` and `key`.
- Support Drupal 10.3+, 11, and 12.
- Authenticate with OAuth2 tokens.
- Support modern email auth.
- Integrate Azure AD.
- Send secure email
- Configure the connection
- Keep secrets in Key.
- Support Outlook SMTP.
- Handle token auth.
- Enable OAuth2 email
