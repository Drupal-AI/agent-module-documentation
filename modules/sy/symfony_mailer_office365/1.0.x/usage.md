<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Mailer Office365 adds an Office 365 / Microsoft 365 transport to the Symfony Mailer (`symfony_mailer`) module, so Drupal delivers mail through an organisation's Microsoft tenancy over SMTP authenticated with OAuth 2.0 (XOAUTH2) instead of a basic-auth username and password.

---

Microsoft has been switching off **basic authentication** for SMTP on Microsoft 365 tenancies, so the classic "SMTP host, port, username, password" configuration simply stops working. The modern replacement is **OAuth 2.0**, and that is what this module implements — but note the specific flavour, because it changes what you have to do. It uses the **delegated authorization-code flow**, not client-credentials: an administrator registers an application in **Microsoft Entra** (Client ID, Client Secret, Tenant ID, redirect URL `/office365/oauth/callback`), enters those plus the sending mailbox address at `/admin/config/system/mailer/office365`, and then clicks **Login via Microsoft** to perform an interactive consent as that mailbox's user. The resulting access token **and refresh token** are stored in Drupal **state** (`office365_oauth_token`); actual mail delivery then talks to `smtp.office365.com:587` and authenticates each connection with the SASL **XOAUTH2** mechanism (`AUTH XOAUTH2 base64(user=…\x01auth=Bearer <token>\x01\x01)`). This is *SMTP*, not the Microsoft Graph `sendMail` API — the scopes requested are `SMTP.Send`, `IMAP.AccessAsUser.All` and `offline_access`. Wiring is done through Symfony Mailer's own plumbing: the module registers a `mailer.transport_factory` service (`Office365EsmtpTransportFactory`, DSN schemes `office365`/`microsoft`) and a `MailerTransport` plugin `office365_oauth` ("Office 365 - OAuth") that you attach to a **mailing policy**. Because the access token expires (typically ~1 hour) and is renewed with the refresh token, the token must be refreshed regularly: `hook_cron` force-refreshes on every cron run (so cron must run at least every 12 hours before the refresh token itself lapses), or you can run `drush office365:refresh` (`--force`) on your own schedule. Two operational hazards dominate: **saving the config form deliberately clears the stored token and forces a re-login**, and the **Azure client secret has a maximum lifetime** — when it expires, all site mail stops on a date nobody wrote down. The client secret is held in Drupal configuration (or overridden from `settings.local.php`); there is no Key-entity integration, so treat that config as sensitive. Installed version here is **1.0.0-rc1** on core `^10 || ^11`; the project is minimally maintained and its releases are **not covered** by the security advisory policy — reasonable for the component that carries every password-reset e-mail to be watched closely.

---

- Send all Drupal mail through a Microsoft 365 / Office 365 mailbox.
- Replace an SMTP setup that broke when Microsoft disabled basic authentication.
- Authenticate outbound SMTP with OAuth 2.0 (XOAUTH2) tokens instead of a stored password.
- Keep outgoing mail inside a corporate Microsoft tenancy for audit, retention and data-residency.
- Add an "Office 365 - OAuth" transport to a Symfony Mailer mailing policy.
- Route mail from a specific shared or service mailbox in Entra.
- Register a Microsoft Entra application and connect Drupal to it via an interactive login.
- Satisfy an IT / security policy that forbids direct SMTP or third-party mail relays.
- Consolidate all site notification e-mail onto existing Microsoft 365 infrastructure.
- Adopt Symfony Mailer as the mail system while still delivering via Microsoft 365.
- Send mail from an intranet or public-sector site tied to a Microsoft tenancy.
- Avoid contracting a separate transactional-email provider (SendGrid, Mailgun, SES).
- Refresh the OAuth access token automatically on Drupal cron.
- Refresh the OAuth token on a custom interval with `drush office365:refresh`.
- Override the client secret / IDs per-environment from `settings.local.php`.
- Complete OAuth consent once and let the refresh token keep delivery working.
- Diagnose delivery by checking token expiry on the module's status page and the watchdog log.
- Re-authenticate after rotating an expired Azure client secret.
- Provide a stopgap for Microsoft 365 SMTP OAuth until Symfony ships native support.
- Send from a `@yourdomain` corporate address so mail passes SPF/DKIM/DMARC for that domain.
