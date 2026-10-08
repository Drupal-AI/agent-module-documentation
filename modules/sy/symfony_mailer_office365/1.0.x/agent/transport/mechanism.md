<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transport & OAuth mechanism

## End to end

1. **Mailing policy** selects the `office365_oauth` MailerTransport plugin
   (`src/Plugin/MailerTransport/Office365OAuthTransport.php`).
2. Its `getDsn()` produces
   `microsoft://{client_id}:{client_secret}@{smtp_host}:{smtp_port}?tenant_id=…&user=…`
   (defaults `smtp.office365.com:587`; values fall back to the `symfony_mailer_office365.config`
   object when the per-plugin config is empty).
3. Symfony Mailer resolves the `microsoft`/`office365` scheme to
   **`Office365EsmtpTransportFactory`** (`services.yml` tag `mailer.transport_factory`).
4. The factory builds a standard Symfony `EsmtpTransport(host, port, authenticators:
   [XOAuth2Authenticator])`, and sets username = DSN `user`, password = DSN password
   (the password is not used by XOAUTH2 — the token is).
5. On connect, `EsmtpTransport` runs the module's **`XOAuth2Authenticator`**
   (`src/Transport/Smtp/Auth/XOAuth2Authenticator.php`), keyword `XOAUTH2`.
6. The authenticator asks `TokenStateManager::getToken()` for a live access token, then sends:
   `AUTH XOAUTH2 ` + base64 of `user=<mail>\x01auth=Bearer <access_token>\x01\x01`, expecting SMTP
   reply `235`. No token → a messenger error "Could not connect to Office 365" and no auth.

This is **SMTP over STARTTLS on 587**, not the Graph API. TLS is Symfony's `EsmtpTransport` default
(enabled).

## OAuth (delegated authorization-code) — `TokenStateManager`

`src/TokenStateManager.php` wraps a `league/oauth2-client` `GenericProvider`:

- `urlAuthorize` = `https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/authorize`
- `urlAccessToken` = `https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token`
- `redirectUri` = route `symfony_mailer_office365.callback` (`/office365/oauth/callback`, absolute,
  langcode-not-applicable)
- `scopes` = `IMAP.AccessAsUser.All SMTP.Send offline_access` (all under `outlook.office365.com`)
- `tenant_id` defaults to `common` if unset.

Flow:

- `getLoginUrl()` returns the provider authorize URL (plus `&login_hint=<mail>`) and stores the
  provider-generated CSRF **state** in Drupal state `office365_oauth_state`.
- Callback `Office365Controller::OAuthCallback()`: reads `code` + `state`; requires a stored state and
  `hash_equals(stored, returned)`; deletes the state; calls `fetchToken($code)` which does the
  `authorization_code` grant and stores the `AccessToken` (with refresh token) in state
  `office365_oauth_token`. Redirects to `<front>` with a status/error message. Route is `no_cache`.
- `getToken()` loads the token; if expired, calls `refresh()`.
- `refresh($force)` uses the `refresh_token` grant; on failure it logs and **clears** the token.
- `clear()` / config-form save wipe the token.

## Plugin/service inventory

| Thing | Type | Detail |
|---|---|---|
| `office365_oauth` | `MailerTransport` plugin (from `symfony_mailer`) | label "Office 365 - OAuth"; builds the DSN |
| `Office365EsmtpTransportFactory` | service, `mailer.transport_factory` | schemes `office365`, `microsoft`; `supports()` returns TRUE |
| `XOAuth2Authenticator` | service | SASL `XOAUTH2` SMTP authenticator |
| `TokenStateManager` | service | OAuth provider + token store/refresh; state keys `office365_oauth_token`, `office365_oauth_state` |

The module does **not** define a new plugin manager/type; it contributes one transport plugin and one
transport factory into Symfony Mailer's existing machinery.
