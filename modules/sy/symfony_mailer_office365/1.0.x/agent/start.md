<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# symfony_mailer_office365 — agent start

Office 365 / Microsoft 365 **transport for Symfony Mailer** (`symfony_mailer`). Installed
version **1.0.0-rc1**, core `^10 || ^11`. Depends on `symfony_mailer` and Composer library
`league/oauth2-client:^2.7`. Not security-advisory covered.

## What it actually does (read this first)

- Delivers mail over **SMTP** to `smtp.office365.com:587`, authenticating each connection with
  the SASL **XOAUTH2** mechanism using an OAuth2 **access token**. It is **not** Microsoft Graph
  `sendMail` and **not** client-credentials — it is the **delegated authorization-code** flow.
- OAuth is done with `league/oauth2-client` `GenericProvider` against
  `https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/{authorize,token}`. Scopes:
  `IMAP.AccessAsUser.All`, `SMTP.Send`, `offline_access`.
- Access token + refresh token are stored in **Drupal state** key `office365_oauth_token`
  (the OAuth CSRF state in `office365_oauth_state`). No token/secret is written to the log.
- Credentials (`client_id`, `client_secret`, `tenant_id`, `mail`) live in the config object
  `symfony_mailer_office365.config` — plaintext, **no Key-entity integration**; overridable from
  `settings.local.php` via `$config['symfony_mailer_office365.config'][...]`.

## Setup flow

1. Register an app in **Microsoft Entra**; add redirect URL `https://SITE/office365/oauth/callback`.
2. Enter Client ID / Client Secret / Tenant ID / sending e-mail at
   `/admin/config/system/mailer/office365` (route `symfony_mailer_office365.config`,
   permission `administer mailer`).
3. Add the **Office 365 - OAuth** transport (`office365_oauth`) to a Symfony Mailer mailing policy.
4. Click **Login via Microsoft** on the config page → interactive consent → callback stores the token.

## Wiring (how mail leaves)

- Service `Office365EsmtpTransportFactory` — tagged `mailer.transport_factory`, DSN schemes
  `office365` / `microsoft`; builds a Symfony `EsmtpTransport` whose authenticator is the module's
  `XOAuth2Authenticator`.
- `MailerTransport` plugin `office365_oauth` (`Office365OAuthTransport`) generates the DSN
  `microsoft://{client_id}:{client_secret}@smtp.office365.com:587?tenant_id=…&user=…`.
- `XOAuth2Authenticator::authenticate()` pulls the current token from `TokenStateManager` and sends
  `AUTH XOAUTH2 base64("user=<mail>\x01auth=Bearer <token>\x01\x01")`.

## Token lifecycle (critical operationally)

- `hook_cron` calls `TokenStateManager::refresh(TRUE)` every cron run — run cron ≥ every 12 h.
- `drush symfony_mailer_office365:refresh` (alias `office365:refresh`, `--force`) refreshes on demand.
- **Saving the config form clears the token and forces a re-login** (`buildStateForm` / `clear()`).
- Access token ~1 h life; if the refresh token lapses (no refresh in time), delivery stops until
  someone logs in again. **Azure client secrets also expire** — a silent hard stop for all mail.

## Detail pages

- Configuration, credentials, settings.php override, token refresh, permissions →
  [configure/settings.md](configure/settings.md)
- Transport internals: factory, DSN, MailerTransport plugin, XOAUTH2 authenticator, OAuth flow →
  [transport/mechanism.md](transport/mechanism.md)

## Files

- `symfony_mailer_office365.services.yml` — transport factory, token-state manager, authenticator.
- `src/TokenStateManager.php` — OAuth provider, token store/load/refresh, login/redirect URLs.
- `src/Plugin/MailerTransport/Office365OAuthTransport.php` — the `office365_oauth` transport plugin.
- `src/Office365EsmtpTransportFactory.php` — Symfony transport factory.
- `src/Transport/Smtp/Auth/XOAuth2Authenticator.php` — SASL XOAUTH2 SMTP authenticator.
- `src/Controller/Office365Controller.php` — `/office365/oauth/callback`.
- `src/Form/Office365ConfigForm.php` — config + status/login page.
- `src/Drush/Commands/Office365DrushCommands.php` — `office365:refresh`.
