<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services Token (services_token) — agent index

**Provides an HTTP Basic token authentication provider and token-minting endpoints for Drupal web services.**

- **Version:** 2.1.x
- **Core:** ^10 || ^11 · package Web services
- **Permission:** `generate services token` (mint tokens)
- **Endpoints:** `POST /services_token/generate` (REST resource `services_token:generate`); Services ServiceDefinition `services_token/generate`
- **Auth provider:** `services_token` (tag `authentication_provider`, priority 200); token = `hex(uid).hex(expire).hmac`, sent as Basic username with empty password
- **Services:** `services_token.token_generator`, `services_token.security_key`, `services_token.realm_resolver`, page-cache policy `DisallowTokenAuthRequests`
- **Settings:** `services_token_private_key`, `services_token_ttl`, `services_token_realm`

**Security:** token endpoints permission-gated; tokens are stateless HMAC-SHA256 (`Crypt::hmacBase64`) compared with constant-time `hash_equals`, bound to the account's password hash and status so they self-invalidate; authenticated requests are excluded from the page cache. No anonymous or mutating endpoints.

See [api/token.md](api/token.md)
