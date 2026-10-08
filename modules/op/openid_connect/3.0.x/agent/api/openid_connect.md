# API — flow, services & extension hooks

## The login / claims flow

1. `OpenIDConnectClientBase::authorize()` redirects the user to the provider's authorization
   endpoint with a CSRF `state` token (`openid_connect.state_token`) and the requested scopes.
2. The provider returns to `/openid-connect/{openid_connect_client}`
   (`OpenIDConnectRedirectController::authenticate`), which validates state and calls the client's
   `retrieveTokens($code)` then `retrieveUserInfo($access_token)`.
3. The central `OpenIDConnect` service (`openid_connect.openid_connect`) runs
   `completeAuthorization($client, $tokens)` — it decodes the ID token, invokes the pre-authorize
   hook, resolves the account via the `externalauth` authmap (keyed by `sub` + client), and
   otherwise creates one with `createUser()` / `generateUsername()`, then maps claims to fields in
   `saveUserinfo()`. `connectCurrentUser()` links a provider to the already-logged-in user.

## Services

| Service id | Class | Use |
|---|---|---|
| `openid_connect.openid_connect` | `OpenIDConnect` | `completeAuthorization()`, `connectCurrentUser()`, `createUser()`, `saveUserinfo()`, `hasSetPasswordAccess()` |
| `openid_connect.claims` | `OpenIDConnectClaims` | `getClaims()`, `getOptions()` (Form API), `getScopes($client)` → space-delimited scopes |
| `plugin.manager.openid_connect_client` | `OpenIDConnectClientManager` | discover/instantiate client plugins |
| `openid_connect.state_token` | `OpenIDConnectStateToken` | `generateToken()` / `confirm()` CSRF state |
| `openid_connect.session` | `OpenIDConnectSession` | stash destination / op across the redirect |
| `openid_connect.autodiscover` | `OpenIDConnectAutoDiscover` | `fetch($issuer_url)` → `.well-known` endpoints |

All services are autowirable by their interface/class name (e.g.
`Drupal\openid_connect\OpenIDConnectClaims`). `openid_connect.claims` exposes the standard OIDC
claims (name, email, given_name, picture, zoneinfo, phone_number, address, …), each with a `scope`
(`profile`/`email`/`phone`/`address`); `getScopes()` returns the minimal scope set implied by the
configured `userinfo_mappings`.

## Extension hooks — `openid_connect.api.php`

Implement these in a custom module (`mymodule_<hook>()`), most receive a `$context` array with
`tokens`, `user_data`, `userinfo`, `plugin_id`, `sub`:

| Hook | When / use |
|---|---|
| `hook_openid_connect_claims_alter(&$claims)` | Add/modify claims shown in the mapping UI |
| `hook_openid_connect_client_info_alter(&$client_info)` | Add or re-class client plugin definitions |
| `hook_openid_connect_userinfo_alter(&$userinfo, $context)` | Rewrite provider userinfo before mapping |
| `hook_openid_connect_user_properties_ignore_alter(&$skip, $context)` | Control which user props are (not) mapped |
| `hook_openid_connect_pre_authorize($account, $context)` | Return an account to authorize, `FALSE` to deny, or `TRUE` |
| `hook_openid_connect_userinfo_claim_alter(&$value, $context)` | Preprocess a single claim value before it is set |
| `hook_openid_connect_userinfo_save($account, $context)` | Copy extra provider data (roles, fields) before save |
| `hook_openid_connect_post_authorize($account, $context)` | Act after login & mapping (e.g. store tokens) |
| `hook_openid_connect_redirect_logout_alter(&$response, $context)` | Alter the IdP end-session redirect response |
