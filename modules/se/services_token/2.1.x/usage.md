<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Supplies an HTTP Basic authentication provider that authenticates web-service requests with a signed, stateless token passed in the username field, plus endpoints to mint those tokens.

---

The module is an alternative to Drupal's cookie session for API clients: a client authenticates once (with normal credentials against the token-generate endpoint) and receives a token string of the form `hex(uid).hex(expire).hmac`. On later requests the client sends that token as the HTTP Basic *username* with an empty password; the `services_token` authentication provider (tagged `authentication_provider`, priority 200) validates the HMAC and loads the user. Tokens are never stored — verification recomputes the SHA-256 HMAC (`Crypt::hmacBase64`) over the uid, expiry and a set of per-user properties and compares with `hash_equals` (constant time), then checks the expiry against request time.

The signing key defaults to the `services_token_private_key` setting and falls back to Drupal's private key plus the hash salt; override it in `settings.php`. Because the default `hook_services_token_properties()` folds the account name, password hash and status into the signature, changing a user's password or blocking them silently invalidates all their outstanding tokens. Token generation is exposed two ways: a REST resource (`POST /services_token/generate`) and a Services module ServiceDefinition plugin at `services_token/generate`, both gated by the `generate services token` permission. A page-cache request policy denies caching of any request that carries a Basic username, so authenticated responses never leak into the page cache. Realm (default `<site name> API`) is overridable via the `services_token_realm` setting.

---
- Add stateless token auth to a REST-configured web service
- Let API clients authenticate without maintaining a Drupal session cookie
- Mint a token with `POST /services_token/generate` (REST) for the current user
- Mint a token through the Services module ServiceDefinition endpoint
- Grant the `generate services token` permission to roles allowed to create tokens
- Send a token as the HTTP Basic username with an empty password on API calls
- Set a dedicated signing key via `$settings['services_token_private_key']`
- Change the default token lifetime with `$settings['services_token_ttl']` (default 30 days)
- Override the authentication realm with `$settings['services_token_realm']`
- Invalidate all of a user's tokens by resetting their password (property changes break the HMAC)
- Invalidate tokens by blocking the account (status is part of the signature)
- Add custom data to the token signature via `hook_services_token_properties()`
- Alter token expiry per request with `hook_services_token_expires_alter()`
- Alter the generated token record with `hook_services_token_create_alter()`
- Inject `services_token.token_generator` to create tokens programmatically
- Inject `services_token.security_key` to verify or generate raw tokens in code
- Rely on constant-time `hash_equals` comparison to resist timing attacks
- Keep authenticated API responses out of the page cache automatically
- Enable alongside the `rest` module to authenticate REST resources
- Pair with the contrib `services` module for its ServiceDefinition endpoint
