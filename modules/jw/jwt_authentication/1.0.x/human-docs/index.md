# JWT Authentication — manual setup guide

**JWT Authentication** (`jwt_authentication`) replaces Drupal's session‑and‑cookie
login with a stateless **JSON Web Token** flow. Instead of a browser session, a
client — a decoupled front‑end, a mobile app, or any API consumer — logs in once,
receives a short‑lived **access token** plus a longer‑lived **refresh token**, and
then calls protected Drupal endpoints by sending the access token in an
`Authorization: Bearer …` header. No cookies, no CSRF token juggling.

The token model is the important part to get right. Access tokens are **signed**
(they carry `uid`, `iss`, `iat`, `exp`, and a unique `jti` claim) and refresh
tokens are opaque UUIDs stored as Drupal entities. A signed token is *trusted
because it verifies against your signing key* — so the security of the whole system
rests on that key. The module can revoke individual tokens before they expire: on
logout it writes the token's `jti` claim to a database blacklist, and every later
request carrying that `jti` is rejected. It also defends the login endpoint with
per‑IP and per‑username flood limits and a timing‑safe guard against username
enumeration, and it prunes expired tokens automatically on cron.

The module exposes three endpoints — `POST /jwt-authentication/api/auth/tokens`
(login), `POST /jwt-authentication/api/auth/refresh` (rotate the pair), and
`POST /jwt-authentication/api/auth/logout` (revoke). Signing keys are stored and
rotated through the **Key** module, and you choose the algorithm (HMAC, RSA, or
ECDSA), the token lifetimes, and an optional audience claim in the admin UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls PHP
   libraries), enable it, and satisfy the Key module and PHP requirements.
2. [Configuration](configuration/index.md) — create a signing key, pick the
   algorithm and token lifetimes, assign permissions, and protect your routes.

## Where it lives in the admin menu

- **Settings:** **Configuration → System → JWT Authentication**
  (`/admin/config/system/jwt-authentication`) — algorithm, key, token lifetimes,
  and audience claim.
- **Keys:** **Configuration → Security → Keys**
  (`/admin/config/system/keys`) — where you create the signing key (provided by the
  Key module).

## The trust model in one paragraph

A JWT is trusted because its signature verifies against your signing key — nothing
else. Anyone who obtains that key can **forge a valid token for any user**, so the
signing key is the single most sensitive secret in this setup. Keep it in the Key
module backed by an environment variable (never in exported config or code), prefer
an asymmetric algorithm (RS256) or a strong HMAC secret, keep access‑token
lifetimes short and rely on refresh, and serve every endpoint over HTTPS so tokens
can't be intercepted in transit.
