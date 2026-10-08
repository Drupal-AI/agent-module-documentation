<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Access Hub makes Drupal a spoke that authenticates against a central hub with signed API calls.

---

User Access Hub allows user authentication through a central User Access Hub — this Drupal acts as a 'spoke' that exchanges handshake, package, role and SSO data with a central hub over `/spoke/api/*` endpoints, so user identity and roles can be managed centrally across multiple sites.

Security: although the `/spoke/api/*` endpoints carry `_permission: 'access content'`, each request is authenticated by an **openssl SHA-384 signature verification** (`openssl_verify` against the hub's configured public key) before any action — including role assignment (`$user->addRole()`) — so forged requests are rejected; the signature (not the route permission) is the real gate. Minor nit: a secondary `apikey` check uses `==` (non-constant-time). Store the hub keys securely (env-backed). Config is gated by `administer user access hub configuration`. Supports Drupal 9, 10, and 11.

---

- Authenticate via a central hub.
- Act as a spoke.
- Exchange handshake/roles/SSO data.
- Manage identity centrally.
- Verify openssl SHA-384 signatures.
- Reject forged requests.
- Gate role assignment behind signatures.
- Treat the signature as the real gate.
- Note a secondary `==` apikey nit (non-constant-time).
- Store hub keys securely (env-backed).
- Gate config with `administer user access hub configuration`.
- Depend on the hub's public key.
- Support Drupal 9, 10, and 11.
- Support multi-site identity.
- Handle SSO.
- Assign roles from the hub
- Verify with the public key
- Support central auth
