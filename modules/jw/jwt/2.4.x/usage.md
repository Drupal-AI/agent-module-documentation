<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JWT provides a framework for issuing, validating and authenticating with JSON Web Tokens in Drupal, built around a single site-wide signing key managed through the Key module.

---

The base `jwt` module wires the `firebase/php-jwt` library into Drupal and adds a global `jwt_auth` authentication provider that reads a Bearer token from the `Authorization` (or fallback `JWT-Authorization`) header, verifies its signature and dispatches events so other modules can validate claims and resolve a Drupal user. The signing key is not stored in module config directly; instead you create a **Key** entity (Key module) of type `jwt_hs` (HMAC — HS256/HS384/HS512) or `jwt_rs` (RSA — RS256), then point the module at it on the config form `/admin/config/system/jwt`, which stores only the chosen `key_id` in the `jwt.config` object. The `jwt.transcoder` service encodes/decodes tokens, mapping the key's algorithm to a symmetric secret or an asymmetric public/private key pair, and a `JsonWebToken` value object provides a claim/header get/set API. Three events — `JwtAuthEvents::GENERATE`, `::VALIDATE` and `::VALID` — let modules add claims at issue time and validate/resolve the account at authentication time; the base module ships none of that behaviour itself. On its own `jwt` only provides the key framework, transcoder and provider — to actually authenticate incoming tokens you enable `jwt_auth_consumer`, and to hand out tokens you enable `jwt_auth_issuer` (or `jwt_oauth_ccf`). A page-cache request policy disallows caching any request carrying a JWT so authenticated responses cannot leak into the anonymous page cache. `jwt.config` does not exist until you save the config form, so a freshly enabled site has no key and cannot encode/decode until one is chosen.

---

- Add stateless token authentication to a Drupal REST or JSON:API endpoint so decoupled front-ends authenticate with a Bearer token instead of a session cookie.
- Manage a single site-wide JWT signing key as a Key entity and swap it without code changes.
- Choose an HMAC (shared-secret) signing algorithm HS256/HS384/HS512 for a simple symmetric setup.
- Choose an RSA algorithm RS256 so a token can be verified with a public key while signed with a private key.
- Point the module at a different key by editing only `jwt.config`'s `key_id` (config route `jwt.jwt_config_form`).
- Encode a custom token programmatically via the `jwt.transcoder` service and a `JsonWebToken` object.
- Decode and verify an incoming raw JWT string, catching `JwtDecodeException` on tampered/expired tokens.
- Add custom claims to every issued token by subscribing to `JwtAuthEvents::GENERATE`.
- Reject tokens that fail an application-specific rule by subscribing to `JwtAuthEvents::VALIDATE` and calling `invalidate()`.
- Resolve which Drupal user a validated token maps to by subscribing to `JwtAuthEvents::VALID` and calling `setAccount()`.
- Enable `jwt_auth_consumer` to authenticate tokens carrying a `drupal.uid` / `drupal.uuid` / `drupal.name` claim.
- Enable `jwt_auth_issuer` to expose a `/jwt/token` endpoint that mints a token for the logged-in user.
- Enable `jwt_oauth_ccf` for machine-to-machine (client-credentials-grant) token issuance at `/oauth2/token`.
- Enable `jwt_path_auth` to accept a JWT in a `?jwt=` query string for whitelisted path prefixes (e.g. private files).
- Enable `users_jwt` for per-user RSA public keys instead of one site-wide key.
- Gate the JWT admin pages behind the `administer jwt` permission.
- Restrict a Views REST export to callers presenting a valid JWT by enabling the `jwt_auth` authentication option on the display.
- Include a JWT in a returned link or download URL for time-limited access to protected resources.
- Send a token in the fallback `JWT-Authorization: Bearer` header on environments protected by HTTP basic auth.
- Prevent JWT-authenticated responses from being served from the anonymous page cache (built-in request policy).
- Turn on `$settings['jwt.debug_log'] = TRUE;` to log why a token failed to authenticate during development.
- Generate a cryptographically strong HMAC or RSA key value directly from the Key add form using the JWT key types.
- Build an integration test that mints a token with `JwtAuth::generateToken()` and asserts an endpoint accepts it.
- Rotate signing keys by creating a new Key entity and repointing `jwt.config`, invalidating previously issued tokens.
