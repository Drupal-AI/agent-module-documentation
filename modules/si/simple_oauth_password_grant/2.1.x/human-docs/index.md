# Simple OAuth Password Grant — manual setup guide

**Simple OAuth Password Grant** (`simple_oauth_password_grant`) adds the OAuth2
**password grant** (the "resource owner password credentials" flow) to the Simple
OAuth module. With it, a trusted first‑party client — your own single‑page app or
native mobile app — can exchange a Drupal username (or email) and password for an
OAuth2 access token, without the redirect‑based login flow. It's a convenient way
to give a headless Drupal front end a simple "log in" endpoint that reuses Drupal
accounts.

Once enabled, the module makes **Password** a selectable grant type on each Simple
OAuth **Consumer**. A client then POSTs `grant_type=password` (with its
`client_id`, `client_secret`, `username`, and `password`) to Simple OAuth's token
endpoint at `/oauth/token` and receives a bearer access token — plus a refresh
token if the consumer allows one. The `username` field accepts either the Drupal
username or the account's email address, and only active accounts can obtain a
token. Credential checking reuses Drupal's own authentication service and applies
core‑style **flood protection**: repeated failed attempts are rate‑limited per IP
and per user, and a blocked request returns an OAuth error with HTTP 403.

The module has no settings page of its own — its only configuration is turning the
**Password** grant on for a consumer, which you do on Simple OAuth's Consumers
screen. It depends on **Simple OAuth** and requires PHP 8.1+.

> **Security warning.** The password grant is explicitly discouraged by current
> OAuth2 best‑practice guidance, because the client handles the user's raw
> password. Use it **only** for trusted, secure, first‑party applications you
> control, and prefer the Authorization Code (with PKCE) flow wherever you can.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. You enable the grant on the Simple OAuth
Consumers screen at **Configuration → Web services → Consumers**
(`/admin/config/services/consumer`), and clients authenticate against Simple
OAuth's token endpoint (`/oauth/token`).

## How to use it

**1. Enable the Password grant on a consumer.** Go to **Configuration → Web
services → Consumers**, add or edit a consumer, and tick **Password** under its
grant types. Set or confirm the consumer's **Default scopes** (the module moves the
scopes selector into a "Default scopes" section on this form), then save. If you
also want refresh tokens, make sure the consumer allows the `refresh_token` grant
too.

**2. Request a token.** Have your client POST to the token endpoint:

```
POST /oauth/token
grant_type=password
client_id=my_app
client_secret=<the consumer secret>
username=<Drupal username OR email>
password=<Drupal password>
scope=<optional space-separated scopes>
```

The response is a JSON body with `access_token`, `token_type: Bearer`,
`expires_in`, and (when allowed) a `refresh_token`. The refresh token's lifetime
comes from the consumer's **Refresh token expiration** setting (14 days by
default). Use the returned access token as a bearer token on subsequent API
requests. Remember the security caveat above — keep the client, and the credentials
it handles, trusted and secure.
