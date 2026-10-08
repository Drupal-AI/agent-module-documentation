<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple OAuth: Fallback Header lets API clients send a Simple OAuth bearer access token in an alternative `X-OAuth-Authorization` HTTP header (or optionally an `access_token` GET query) when the standard `Authorization` header is unavailable or already used for basic/digest HTTP auth.
---
The module decorates Simple OAuth's `page_cache_request_policy.disallow_oauth2_token_requests` service. Its `isOauth2Request()` override calls `getAccessToken()`: it reads the configurable fallback header (default `X-OAuth-Authorization`; renameable via `$settings['simple_oauth_fallback_header']`) and, if `$settings['simple_oauth_allow_get_query']` is TRUE, falls back to the `access_token` GET parameter. When a token is found it is copied into the `Authorization` header as `Bearer <token>` (overwriting any existing Authorization value), after which the parent Simple OAuth logic proceeds unchanged.

This is a transport convenience, not a new authentication path: the copied token is still fully validated by Simple OAuth's normal token authentication, so an invalid or missing token grants no access — there is no bypass of token auth. The main operational caveats are that (1) a present fallback header/query **overwrites** the real `Authorization` header for the rest of the request, and (2) enabling `simple_oauth_allow_get_query` puts tokens in URLs/logs, which is why RFC 6750 discourages it. There are no routes, permissions, forms or config schema; behaviour is driven solely from `settings.php`, and a service provider (documented in README) can remove Simple OAuth's basic-auth-swap middleware for server-side HTTP auth coexistence.
---
- Authenticate Simple OAuth API requests using an `X-OAuth-Authorization` header.
- Combine OAuth bearer auth with basic/digest HTTP auth without header conflicts.
- Rename the fallback header via `$settings['simple_oauth_fallback_header']`.
- Optionally accept tokens in an `access_token` GET query (RFC 6750 §2.3).
- Enable the GET-query mode with `$settings['simple_oauth_allow_get_query'] = TRUE`.
- Keep the standard `Authorization` header free for server-side HTTP auth.
- Install as zero-config plug-and-play for existing Simple OAuth setups.
- Prioritise the custom header over `Authorization` and GET query.
- Remove `simple_oauth.http_middleware.basic_auth_swap` via a service provider.
- Let reverse proxies / gateways that strip `Authorization` still pass tokens.
- Support mobile/API clients that reserve `Authorization` for another scheme.
- Preserve Simple OAuth's token validation and scopes unchanged.
- Test alternate-header auth with the bundled test module/route.
- Debug which token source (header vs query) won a given request.
- Migrate clients gradually from GET-query tokens to header tokens.
