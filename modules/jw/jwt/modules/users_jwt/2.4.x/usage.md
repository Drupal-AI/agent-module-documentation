<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Users' JWT Authentication lets each Drupal user register one or more RSA public keys and authenticate API requests by signing a JWT with the matching private key — no shared secret, no session cookie.

---

The module adds an `authentication_provider` (`users_jwt_auth`, priority 150) that inspects every request for a raw JWT in the `Authorization` header using the scheme keyword `UsersJwt` (e.g. `Authorization: UsersJwt <token>`), with `JWT-Authorization: UsersJwt <token>` as a fallback header for environments already using `Authorization` for HTTP Basic auth. Each user manages their own keys at `/user/{user}/jwt-keys`: add an existing PEM public key, generate a fresh RSA keypair (the private key is streamed as a one-time download, only the public key is stored), edit, or delete. Keys live in the core `user.data` key-value store under the module name `users_jwt`, keyed by a globally-unique key ID (`kid`), as a `Drupal\users_jwt\UsersKey` object with `{uid, id, alg, pubkey}`. To authenticate, the client signs a JWT whose header's `kid` names one of its registered keys and whose payload carries `iat`, `exp` (capped to 24 hours in code today), and an identity claim under `drupal.uid` / `drupal.uuid` / `drupal.name`; the provider loads the key by `kid`, verifies the signature and that the JWT's `alg` matches the stored key's `alg`, then loads and returns the matching, non-blocked user — but only if that user's uid also matches the key's owning uid. The module ships a config schema for `users_jwt.config: {max_expiration: int}`, but no settings form ships and nothing in the code currently reads that key, so at present the 24-hour cap is a hard-coded constant, not (yet) an enforced configurable value. It may be installed independently of the main `jwt` module and declares no formal dependency on it.

---

- Let API clients authenticate as a specific Drupal user via a signed JWT instead of a session cookie or shared secret.
- Register one or more RSA public keys per user account for use as sign-in credentials.
- Generate a fresh RSA keypair in the browser and download the private key exactly once.
- Add an externally generated PEM-encoded RSA public key to a user's account by pasting it in.
- Authenticate REST/JSON:API requests by sending `Authorization: UsersJwt <token>`.
- Use the fallback `JWT-Authorization` header when the primary `Authorization` header is already used for HTTP Basic auth (e.g. staging environments behind a basic-auth gate).
- Look up which public key authenticated a request via the JWT header's `kid` claim.
- Enforce that a JWT's `alg` (e.g. `RS256`) matches the algorithm recorded for the stored key, rejecting mismatches.
- Require both `iat` and `exp` claims on every JWT and reject tokens whose lifetime exceeds 24 hours.
- Identify the target Drupal account from a `drupal.uid`, `drupal.uuid`, or `drupal.name` claim in the JWT payload.
- Reject authentication when the key's owning uid doesn't match the uid resolved from the JWT payload, preventing key/identity spoofing.
- Reject authentication for blocked user accounts even if their key and signature are valid.
- List, edit, and delete a user's registered keys from the `/user/{user}/jwt-keys` management page.
- Give an administrator (with `user.update` access) the ability to manage another user's keys, including choosing a custom key ID.
- Programmatically save, fetch, or delete a user's keys via the `users_jwt.key_repository` service instead of the UI.
- Build automated/service integrations that sign requests as a specific service account without issuing that account a password.
- Rotate a compromised key by deleting it and generating/adding a replacement, without affecting the user's password or other keys.
- Support machine clients (CI jobs, mobile apps, IoT devices) that hold a private key and never need to send credentials over the wire.
- Combine with `jwt` core services for JWT decoding utilities while keeping key storage and lookup entirely local to `users_jwt`.
- Give each user multiple keys (e.g. one per device or per integration) that can be revoked independently.
- Enable `users_jwt_auth` as a REST/JSON:API authentication provider for headless/decoupled front ends.
- Inspect a user's public keys programmatically (`getUsersKeys($uid)`) for auditing or provisioning tooling.
- Debug failed authentication attempts by enabling `$settings['jwt.debug_log'] = TRUE` in `settings.php`, which logs the cause, exception, payload, key, and user.
- Enable this module standalone, without installing the main `jwt` module, when only per-user public-key auth is needed.
