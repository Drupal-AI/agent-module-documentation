# Configuration

Setting this up is a round trip between your identity provider and Drupal: register
an app at the provider, enter its details in Drupal, test the connection, then turn
on the login link.

All the admin pages live under **Configuration → People → miniOrange OAuth Login**
(`/admin/config/people/oauth_login_oauth2/…`) and use core's *Administer site
configuration* permission. The tabs are:

- **Configure Application** (`config_clc`) — the main form (below).
- **Attribute & role mapping** (`mapping`) — mostly premium.
- **Sign-in settings** (`Settings`) — base URL / HTTPS callback.
- **Troubleshooting** (`MoOAuthTroubleshoot`) — logs and diagnostics.
- **Login reports** (`LoginReports`) — premium.

## 1. Register the app at your provider

At your OAuth/OIDC provider, create an application and set its **redirect URI** to:

```
https://<your-site>/mo_callback
```

Note the client id and client secret it issues, and the provider's authorize,
token, and userinfo endpoint URLs.

## 2. Fill in the Configure Application form

Go to **Configure Application**
(`/admin/config/people/oauth_login_oauth2/config_clc`) and enter:

- **Client ID** — the client id from your provider.
- **Client secret** — the secret from your provider. It's stored **encrypted at
  rest** (using a key derived from the site's private key), so it isn't kept as
  plaintext in config. Treat the site's private key as sensitive, since the secret
  is recoverable by anything that can read it.
- **Scope** — the scopes to request, for example `openid email profile`.
- **Authorize endpoint** — the provider's authorize URL.
- **Access token endpoint** — the provider's token URL.
- **Userinfo endpoint** — the provider's userinfo URL. (If this URL ends in `=`,
  the access token is appended to the query string.)
- **Callback / redirect URI** — should be `https://<your-site>/mo_callback`, the
  same value you registered at the provider.
- **Send credentials in body vs header** — choose whether the client id/secret are
  sent in the token request **body** (the default) or as an HTTP Basic
  **Authorization header**, according to what your provider expects.
- **Display link** — the label of the "Login with …" link added to the standard
  `/user/login` page.

## 3. Test the configuration and pick the email attribute

Visit **Test Configuration** (`/testSSO`). This performs a real login round-trip
and shows you exactly which attributes your provider returns. From that list, pick
the attribute that holds the user's **email address** — this is what the module
matches against existing Drupal accounts (via the account's email). Save it.

Because the free version matches by email and does **not** create accounts, the
matched email must already belong to a Drupal user; unknown emails get an error
page.

## 4. Enable login and (optionally) force HTTPS

- Make sure **login with OAuth is enabled** (the master switch) — otherwise
  `/moLogin` returns an error.
- On the **Sign-in settings** tab, if your site sits behind a TLS-terminating
  proxy, you can force the base/callback URL to `https://` so the callback isn't
  built as `http://`.
- Turn on **verbose logging** temporarily (on the form) if you need to debug the
  token or userinfo responses in the Drupal log.

## How login works

1. A visitor clicks the login link (or hits `/moLogin`, which supports a
   `?destination=` parameter to return them to a specific page afterward).
2. They're redirected to the provider's authorize endpoint.
3. The provider returns them to `/mo_callback`; the module exchanges the code for
   an access token, fetches their profile, matches the configured email attribute
   to an existing Drupal user, and logs them in.
