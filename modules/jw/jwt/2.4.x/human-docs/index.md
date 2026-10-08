# JSON Web Token Authentication (JWT) — manual setup guide

**JSON Web Token Authentication** (`jwt`) is a framework for issuing, validating, and
authenticating with **JSON Web Tokens** in Drupal. JWTs are stateless, signed bearer tokens
that a client sends in an `Authorization: Bearer …` header instead of a session cookie — the
usual way a decoupled front‑end, a mobile app, or another service authenticates against a
Drupal REST or JSON:API endpoint. The module wires the well‑known `firebase/php-jwt` library
into Drupal, adds a global `jwt_auth` authentication provider that reads and verifies the
incoming token, and dispatches events so tokens can be given custom claims and mapped to a
Drupal user.

At the heart of it is a **single site‑wide signing key**. JWT does not store secret material
in its own config; instead you create a **Key** entity (using the Key module) and point JWT at
it. You choose the signing algorithm when you create that key: an **HMAC** key (`jwt_hs` —
`HS256`/`HS384`/`HS512`) uses one shared secret to both sign and verify, which is the simplest
setup; an **RSA** key (`jwt_rs` — `RS256`) signs with a private key and lets others verify with
the public key, which suits scenarios where the verifier shouldn't hold the signing secret. JWT
stores only the chosen key's id in its `jwt.config` object, so rotating keys is a matter of
creating a new Key entity and repointing the module — which conveniently invalidates all
previously issued tokens.

Importantly, the **base module by itself only provides the framework** — the key handling, the
token encode/decode service, and the authentication provider. It does not authenticate incoming
tokens or hand any out until you enable the right submodule: **JWT Authentication Consumer** to
*validate* incoming tokens and resolve the user, and **JWT Authentication Issuer** (or the OAuth
client‑credentials variant) to *mint* tokens. The module requires **PHP 7.4+**, the
`firebase/php-jwt` library, and the **Key** module; RSA keys additionally need PHP's OpenSSL
extension. It targets **Drupal 9, 10, or 11**.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — including the transcoder service, the
`JsonWebToken` claim API, and the three authentication events — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base module, and
   pick the submodules for issuing and/or consuming tokens.
2. [Configuration](configuration/index.md) — create a signing Key, choose the algorithm, point
   JWT at it, and the permission that guards the admin pages.

## Where it lives in the admin menu

- **JWT's own settings:** **Configuration → System → JSON Web Token Authentication**
  (`/admin/config/system/jwt`), where you select the signing key. Guarded by the **Administer
  JSON Web Token module** permission.
- **The signing keys themselves:** **Configuration → System → Keys**
  (`/admin/config/system/keys`), provided by the Key module, where you create the `jwt_hs` or
  `jwt_rs` key.

## How to use it

The order that matters: **create a Key first, then point JWT at it** — a freshly enabled site
has no key and cannot encode or decode tokens until one is chosen. After that, enable a
consumer submodule to authenticate incoming tokens and/or an issuer submodule to hand tokens
out, and enable the `jwt_auth` authentication option on the REST/Views/JSON:API resources you
want to protect. The full setup is in [Configuration](configuration/index.md).
