# SSO runtime flow, routes, and integration points

Two controllers implement the login round-trip; both `_no_cache`, both `_access: 'TRUE'` (anonymous by
design — the IdP calls the callback unauthenticated).

## 1. Authorization request — `MoAuthorizationRequestController::__invoke`

Route `mo_oauth.authorization_request` → `/mo-oauth-client/user/login/{mo_client_config}`.

1. Kills the page cache, validates the license, loads the `mo_client_config`.
2. Refuses unless `getEnableLoginWithOauth()` is TRUE (or it is a `test_sso` run).
3. `generateState()` builds an array `{head: base64url(random_bytes(12)), app_id, destination?, user_lang?, tail: base64url(random_bytes(12))}`, JSON-encodes it, and base64url-encodes the whole thing. `destination` is derived from the request `?destination=` (reduced to a path only via `parse_url(..., PHP_URL_PATH)`, `Html::escape`-d) or the HTTP referer, then prefixed with the site's own base URL.
4. `updateSessionData()` stores that exact encoded `state` in the session as `mo_oauth2state` (plus `mo_oauth_app_id`, `mo_sso_request_time`).
5. Builds the provider authorize URL (`MoUnoAuthorizationCodeGrant::buildAuthorizationUrl`:
   `response_type=code`, `redirect_uri`, `scope`, `state`, client id) and returns a
   `TrustedRedirectResponse` (or an auto-submitting POST form when the connection's request method is `post`).

## 2. Callback — `MoAuthorizationResponseController::__invoke`

Route `mo_oauth.authorization_response` → `/mo-oauth-client/callback/{mo_client_config}`.

1. Sanitizes query params (`MoUtilities::sanitizeRecursive`, `Html::escape` on every key/value).
2. **`validateState()`** — decodes `?state`, then enforces `req_state === session['mo_oauth2state']`
   (throws "State mismatched" otherwise) and that the state's `app_id` matches the loaded config id.
   This is the CSRF / request-forgery guard; it also carries the trusted `destination` out of the state.
3. `fetchToken()` → `MoUnoOAuth20::gatherTokenFromIdp` exchanges `code` at the token endpoint; a missing
   `access_token` throws.
4. Removes `mo_oauth2state` from the session (one-shot).
5. `performSsoInDrupalByToken()` fetches the resource owner and logs the user in (below).

## 3. `performSsoInDrupalByToken(array $token_data, string $token_app_name = '')`

Public entry point you can call directly to complete SSO from a token you already hold:

- `fetchResourceOwner()` → `MoUnoOAuth20::gatherUserInfoFromIdp` does a Bearer GET to the configured
  **userinfo endpoint** (OAuth protocol) and returns the claims. (For the OAuth protocol there is no
  id-token/JWT signature step — trust derives from fetching claims directly from the configured
  endpoint over the client's own back channel; OpenID id-token handling lives in the licensed
  Standard/Enterprise tier, not shipped here.)
- Requires the mapped email/login claim; matches an existing Drupal user (`checkUserExists`), or creates
  one (`createUser`, licensed tiers only — free tier throws a feature-restriction error).
- Applies attribute restriction, domain restriction, role/group/profile mapping, then
  `MoUnoLoginOperations::userLogin`, writes a Login Report row, and ties token expiry to the session.
- Returns a `RedirectResponse` to the trusted `destination` from the state, else the user's canonical page.

## Other routes

- `mo_oauth.validate_domain_to_redirect` (`/mo-oauth-client/validate-domain-to-redirect`, anonymous) —
  pre-login domain→IdP lookup for domain-based redirection.
- Front-channel logout is handled by an `http_middleware` (`MoFclLogoutMiddleware`, priority 350).

## Invited hooks (via `MoUnoHooksLoader`, delegating to the tier hooks loader)

There is no `*.api.php`; these extension points are invoked during the flow and forwarded to the
licensed Standard-tier loader. Hook points and their mutable payloads:

| Point | When | You can change |
|---|---|---|
| `authorizationStateBuild` | building `state` | add entries to `$state` (by-ref) |
| `preAuthReqProcess` | before redirecting to IdP | `$authorization_url` (by-ref) |
| `preAuthRespProcess` | callback, after state validation | inspect `$query_params` |
| `postTokenRequest` | after token exchange | `$token_data`, `$state` |
| `postResourceOwnerFetch` | after userinfo fetch | `$normalized_resource_owner` (by-ref) |
| `modifyGroupInfoEndpoint` | group fetch | `$group_info_ep` (by-ref) |
| `modifyLoginLink` / `preLogout` / `domainBasedRedirectHook` | login-form / logout / domain redirect | see method signatures |

## Security notes for integrators

- The callback is intentionally anonymous; do not add your own access check that would break the IdP
  round-trip — the `state` equality check is the request-forgery defense.
- The post-login `destination` cannot be tampered with at the callback (it lives inside the
  session-bound `state`, which must match byte-for-byte) and is constrained to the site's own base URL,
  so this is not an open-redirect vector. If you extend the flow, keep new redirect targets equally
  constrained.
- Error/response bodies can echo the raw IdP response (e.g. the "Invalid response received..." exception
  `print_r`s `$content`); avoid surfacing those verbatim to end users in custom error handling.
