<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple OAuth Revoke (simple_oauth_revoke) — agent index

RFC 7009 token-revocation endpoint for `simple_oauth`. One route, one controller, one hook. No
config, no permissions, no services file, no admin UI. Version **3.0.0**, core `^10 || ^11`,
requires `drupal/simple_oauth:^6`. Depends on `simple_oauth` (which itself depends on `consumers`).

## What it adds

- **`POST /oauth/revoke`** — route `simple_oauth_revoke.revoke`, `methods: [POST]`, `no_cache: TRUE`,
  `_access: 'TRUE'`. Body is `application/x-www-form-urlencoded` with a required `token` field.
- **`hook_user_predelete`** (`simple_oauth_revoke_user_predelete` in the `.module`) — when a user
  account is deleted, uses `simple_oauth.expired_collector` (`collectForAccount` +
  `deleteMultipleTokens`) to expire all that user's OAuth tokens.

## How revocation works (`src/Controller/Oauth2Revoke.php`)

`Oauth2Revoke::revoke()`:
1. `validateClient()` — authenticate the caller and resolve it to a `consumers` Consumer entity.
2. Require a non-empty `token` param (else `invalidRequest`).
3. `revokeAccessToken()` then `revokeRefreshToken()` — one of the two matches the token type.
4. Return HTTP **200** on success or on an unknown/invalid token; return the OAuth error response
   only on a real error (bad client, missing token). 200-on-unknown is deliberate (no existence
   oracle).

**Client authentication — `validateClient()`** (in priority order):
- HTTP Basic auth `client_id`/`client_secret` (`$request->getUser()` / `getPassword()`); if that
  client_id is empty or unknown, fall back to body `client_id`/`client_secret`.
- If a client_id is present, it must pass `clientRepository->validateClient()` or `invalidClient` is
  thrown.
- If **no** client_id at all, fall back to the current request's own OAuth bearer auth: if the
  current user's account is a `TokenAuthUser`, use `$token->getConsumer()`. ("For convenience, we'll
  also allow a valid access token.")
- Otherwise `invalidClient`.

**Ownership is enforced on both paths — no cross-client IDOR:**
- `revokeAccessToken()` replays the token as a `Bearer` against the resource server
  (`validateAuthenticatedRequest`), reads `oauth_client_id`, and throws `invalidRequest` /
  "Mismatched client ID" unless it equals the authenticating consumer's `getClientId()`. Only then
  is `accessTokenRepository->revokeAccessToken()` called.
- `revokeRefreshToken()` decrypts the token with `Core::ourSubstr(Settings::getHashSalt(), 0, 32)`
  (the same key `Oauth2GrantManager::getAuthorizationServer` uses), json-decodes the attributes, and
  likewise requires `attributes['client_id'] == consumer->getClientId()`. It then revokes the
  refresh token **and** the associated `access_token_id`, so a refresh-token revocation cascades to
  its access token.

A token that decrypts/validates as neither type simply makes both helpers return FALSE, and the
endpoint still answers 200.

## Solution-type docs

- [`endpoints/oauth-revoke.md`](endpoints/oauth-revoke.md) — the `/oauth/revoke` request/response
  contract, auth options, and worked `curl` examples.

## Notes for callers

- There is **no** UI, form, or Drupal permission — this is a machine-to-machine endpoint driven by
  OAuth client credentials, not by a logged-in session (the bearer fallback requires a
  `TokenAuthUser`, which cookie sessions are not, so it is not CSRF-reachable from a browser session).
- Revocation requires possessing the actual token string; you cannot revoke by id.
- The endpoint has no built-in flood/rate limiting; front it with core Flood or a reverse proxy if
  abuse of the unauthenticated-reachable POST is a concern.
