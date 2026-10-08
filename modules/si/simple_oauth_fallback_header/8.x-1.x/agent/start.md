<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple OAuth: Fallback Header (simple_oauth_fallback_header) — agent index

**Accepts a Simple OAuth bearer token from an `X-OAuth-Authorization` header (or `access_token` GET) as a fallback for `Authorization`.**

- **Version:** 8.x-1.x (release 8.x-1.4)
- **Core:** ^9 || ^10 || ^11
- **Requires:** simple_oauth
- **Mechanism:** decorates `simple_oauth.page_cache_request_policy.disallow_oauth2_token_requests` (`DisallowSimpleOauthRequests`); copies the found token into `Authorization: Bearer <token>` then defers to Simple OAuth.
- **settings.php:** `simple_oauth_fallback_header` (header name, default `X-OAuth-Authorization`), `simple_oauth_allow_get_query` (bool, default FALSE).
- **Priority:** custom header > `access_token` GET query > standard `Authorization`.
- **Security:** No auth bypass — the token is still validated by Simple OAuth's normal token authentication; an invalid/absent token grants nothing. Caveats: a present fallback header/query **overwrites** the existing `Authorization` header for the request; enabling the GET-query mode exposes tokens in URLs/logs (RFC 6750 discourages it). No routes/permissions/config schema.

See [configure/settings.md](configure/settings.md).
