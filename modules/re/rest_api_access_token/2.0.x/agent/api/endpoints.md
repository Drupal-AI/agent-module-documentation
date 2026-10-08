<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endpoints, auth headers, signature & events

## Endpoints (`rest_api_access_token.routing.yml`)
| Method + path | Access | Body / headers | Returns |
|---|---|---|---|
| `POST api/v1/auth/token` | anonymous (`_access: TRUE`) | JSON `{ "login": "...", "password": "..." }` | `{ token, secret, userId }` (HTTP 200) |
| `POST api/v1/auth/logout` | token-authed (`_auth: [rest_api_access_token]`) | `X-AUTH-TOKEN` header | `{ loggedOut: bool }` |
| `POST api/v1/auth/logout-from-all-devices` | token-authed | `X-AUTH-TOKEN` header | `{ loggedOut: bool }` |

`login` is matched against the username and/or email (per `login_by_name` / `login_by_mail` config); password is checked by core `user.auth`. `logout` deletes the presented public token; `logout-from-all-devices` deletes all tokens for the current user.

## Authenticating a request (`AccessTokenProvider`)
- Registered as an authentication provider `global: TRUE`, priority 101 (applies to any route that respects global auth).
- `applies()` is TRUE when `X-AUTH-TOKEN` is present in **either a request header or a query parameter**. The same header-or-query fallback is used for `X-AUTH-SIGNATURE` and `REQUEST-ID`.
- Flow: read public token → `TokenRepository::getByPublicToken()` → if not found, `AccessDenied` → load user, require `isActive()` → refresh token timestamp (throttled to once/60s) → return the user.
- If `cache_endpoints` is on, an empty `REQUEST-ID` on an authed request throws `InvalidRequestIdException`.

Header names (constants on `AccessTokenProvider`):
```
X-AUTH-TOKEN      // the public token (the bearer credential)
X-AUTH-SIGNATURE  // required only when signature_verification is on
REQUEST-ID        // required when cache_endpoints is on; also the cache key
```

## Signature verification (opt-in)
When `signature_verification` is enabled the provider computes:
```
value     = publicToken . "|" . requestId . "|" . path . "|" . base64_encode(body) . "|" . secret
expected  = hash('sha256', value)
```
and rejects the request if `X-AUTH-SIGNATURE` does not match `expected`. The `secret` (returned once at login) is the shared key and is never transmitted on normal requests.

## Token generation (`TokenGenerator::execute`)
```php
$publicToken = hash('sha256', bin2hex(random_bytes(64)));  // 512 bits CSPRNG
$secretToken = hash('sha256', bin2hex(random_bytes(32)));  // 256 bits CSPRNG
```
Both are cryptographically random and unpredictable. On login, up to 5 collision retries against existing public tokens; stored via `TokenRepository::insert()`.

## Response cache (`CacheEndpointSubscriber`, opt-in)
- On `kernel.request` (priority 900) if `cache_endpoints` is on and a `REQUEST-ID` is present, a cached `Response` for key `rest_api_access_token_cache:md5(token):<path>:<REQUEST-ID>` is sent and the request short-circuits (`$response->send(); exit;`).
- On `kernel.response` (priority -900) the response is stored with lifetime `cache_endpoints_lifetime` seconds (`0` = permanent, `-1` = disabled).
- `DisallowXAuthTokenRequests` page-cache request policy returns DENY for token requests so Drupal's own page cache never serves them.

## Events (`AccessTokenEvents`)
| Constant | Dispatched from | Use |
|---|---|---|
| `TOKEN_RESPONSE` (`rest_api_access_token.token_response`) | after login, before returning token | inspect/deny via `TokenResponseEvent::setHasAccess(FALSE)` + `setErrorMessage()`; e.g. call `TokenRepository::removeOtherUserTokens($token)` to enforce single-session. |
| `LOGOUT` | logout controller | react to single-device logout. |
| `LOGOUT_FROM_ALL_DEVICES` | logout-all controller | react to global logout. |

Subscribe with a normal `EventSubscriberInterface` service. `TokenResponseEvent` also carries the raw request content array.
