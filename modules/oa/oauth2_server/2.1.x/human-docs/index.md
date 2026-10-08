# OAuth2 Server — manual setup guide

**OAuth2 Server** (`oauth2_server`) turns your Drupal site into a full **OAuth 2.0 /
OpenID Connect authorization server** — an identity provider. Other applications
(single-page apps, mobile apps, external services, or a decoupled front end) can then
let people log in with their Drupal accounts, and your site issues them access tokens,
refresh tokens, authorization codes, and OpenID Connect ID tokens. It is built on the
well-established `bshaffer/oauth2-server-php` library, which handles the sensitive
token, redirect, `state`, and PKCE logic.

The configuration model has three layers that you set up in order:

1. **Servers** — one or more server entities, each enabling a set of grant types
   (Authorization code, Client credentials, Refresh token, User credentials/password,
   JWT bearer, Implicit) and setting token lifetimes and hardening options.
2. **Scopes** — one or more scopes per server (e.g. `basic`, `email`, `profile`), one
   of which can be the default. Scopes appear on the user-consent screen.
3. **Clients** — the applications that connect: each has a client ID and secret,
   allowed redirect URIs, optional per-client grant restrictions, and an
   automatic-authorization flag for fully trusted first-party apps.

It exposes the standard OAuth/OIDC endpoints as Drupal routes — `/oauth2/authorize`,
`/oauth2/token`, `/oauth2/UserInfo`, `/oauth2/revoke`, `/oauth2/tokens/{token}` — plus
`/oauth2/jwk` and `/oauth2/certificates` for the public signing keys. Client secrets
are stored **hashed**, ID tokens are signed RS256 with an RSA keypair the module
generates and rotates roughly daily on cron, and a bundled `oauth2` authentication
provider lets your own routes accept `Authorization: Bearer` access tokens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   bshaffer libraries and needs the openssl/curl/json PHP extensions) and enable the
   module.
2. [Configuration](configuration/index.md) — create a server, add scopes, register a
   client, understand grant types and the signing keys, and set permissions.

## Where it lives in the admin menu

Servers, scopes, and clients are managed under **Structure → OAuth2 Servers**
(`/admin/structure/oauth2-servers`), which requires the **Administer OAuth2 server**
permission. The public keys are served without authentication at `/oauth2/jwk` and
`/oauth2/certificates`; the authorize/token flow requires the **Use OAuth2 server**
permission.
