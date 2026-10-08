<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST API Access Token provides a Drupal authentication provider that authenticates API requests by a token sent in the `X-AUTH-TOKEN` header (or query string), plus login/logout endpoints, optional per-request HMAC-style signature verification, and an optional per-user response cache.

---

Clients obtain a token by POSTing credentials to `api/v1/auth/token`; `LoginService` looks the user up by name and/or mail (per config), verifies the password with core `user.auth`, and `TokenGenerator` mints a `public` and a `secret` token — each `hash('sha256', bin2hex(random_bytes(...)))` (64 and 32 bytes of CSPRNG entropy) — stored in the `rest_api_access_token` DB table with created/refreshed timestamps. Thereafter the `AccessTokenProvider` authentication provider (registered `global: TRUE`, priority 101) `applies()` whenever an `X-AUTH-TOKEN` is present in a header **or query parameter**, loads the token, checks the user is active, refreshes the token's timestamp, and returns the user. When `signature_verification` is enabled, each request must also carry `X-AUTH-SIGNATURE` = `sha256("publicToken|requestId|path|base64(body)|secret")`; the secret is never sent on normal requests. `api/v1/auth/logout` (single device) and `api/v1/auth/logout-from-all-devices` delete tokens, dispatching events (`AccessTokenEvents::TOKEN_RESPONSE`, `LOGOUT`, `LOGOUT_FROM_ALL_DEVICES`) that other modules can subscribe to (e.g. to revoke other sessions). An optional cache (`CacheEndpointSubscriber`) stores full responses keyed by `md5(token):path:REQUEST-ID` when `cache_endpoints` is on; a page-cache request policy prevents Drupal's own page cache from serving token requests. `cron` prunes tokens older than `token_lifetime_hours`. The admin form at `/admin/config/system/rest_api_access_token` (permission `administer rest api access token`) toggles login-by-name/mail, signature verification, cache, cache lifetime, and token lifetime; all protections (signature, cache) are **off by default** (no `config/install` ships).

---

- Add token-based authentication to Drupal REST/JSON:API endpoints for a decoupled or mobile app.
- Issue an access token to a client after verifying username/email + password.
- Authenticate subsequent API requests with an `X-AUTH-TOKEN` header instead of cookies.
- Support login by username, by email, or both (configurable).
- Log a client out of the current device by revoking its token.
- Log a user out of all devices at once (revoke all their tokens).
- Enforce per-request integrity/anti-tamper with optional `X-AUTH-SIGNATURE` HMAC-style verification.
- Automatically expire tokens after N hours via cron (`token_lifetime_hours`).
- Cache API responses per user+request-id to speed up repeated reads (`cache_endpoints`).
- Set a cache lifetime (seconds), permanent (0), or disabled (-1) for cached endpoints.
- Revoke a user's other tokens on login by subscribing to `AccessTokenEvents::TOKEN_RESPONSE`.
- Run custom logic on logout via `AccessTokenEvents::LOGOUT` / `LOGOUT_FROM_ALL_DEVICES`.
- Build a headless Drupal backend where the frontend stores a bearer token.
- Deny a login post-hoc from an event subscriber (`TokenResponseEvent::setHasAccess(FALSE)`).
- Keep Drupal's page cache from serving authenticated token requests (request policy).
- Provide stateless-ish auth for a native mobile client that cannot use cookies.
- Rotate tokens by logging out and logging back in.
- Restrict which admins can change API auth settings via `administer rest api access token`.
- Integrate the auth provider globally so any route respecting global auth can use tokens.
- Prune stale tokens automatically to limit the window of a leaked token.
