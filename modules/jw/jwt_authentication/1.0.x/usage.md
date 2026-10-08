<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JWT Authentication provides stateless JWT-based authentication with token lifecycle and JTI revocation.

---

JWT Authentication **provides stateless JWT auth** — access/refresh token authentication with a token
lifecycle, JTI-based revocation and flood protection, for decoupled/API clients. It stores signing keys via the
**Key** module, in the Authentication package, and provides its own permissions.

Use it to authenticate API/decoupled clients with JWTs. It is an **authentication** feature built with good
primitives: it uses the **Key** module for the signing key (secret handling), supports **JTI revocation** (so
individual tokens can be invalidated, mitigating replay) and **flood** protection. Security essentials: keep the
**JWT signing key strong and secret** (env/Key — a leaked signing key lets anyone forge tokens for any user), prefer
an **asymmetric algorithm (RS256)** or a strong HMAC secret, use **short access-token lifetimes** with refresh, and
serve everything over HTTPS. It has its own permissions. Configure the signing key and token lifecycle.

---

- Provide stateless JWT authentication.
- Support access/refresh token lifecycle.
- Support JTI revocation + flood protection.
- Store signing keys via the Key module.
- Provide its own permissions.
- Serve authentication (API/decoupled).
- USE Key for the signing key + JTI revocation (mitigates replay) + flood.
- Keep the signing key strong + secret (a leak lets anyone forge tokens for any user).
- Prefer RS256 / a strong HMAC secret + short access-token lifetimes + HTTPS.
- Have its own permissions.
- Configure the signing key and token lifecycle.
- Handle JWT auth.
- Issue tokens.
- Configure the keys.
- Verify tokens.
- Handle the lifecycle.
- Revoke tokens.
- Authenticate clients.
- Secure the signing key.
- Provide JWT authentication.
