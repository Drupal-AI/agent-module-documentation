# Endpoints, authentication provider, and protecting your own routes

## OAuth2 endpoints (`oauth2_server.routing.yml` → `OAuth2Controller`)

| Route / path | Access | Purpose |
|---|---|---|
| `oauth2_server.authorize` `/oauth2/authorize` | perm `use oauth2 server` | Authorize endpoint. Anonymous → redirected to login with `destination`. Loads client by `client_id`; if `automatic_authorization` finishes immediately, else validates then shows `AuthorizeForm` consent screen. |
| `oauth2_server.token` `/oauth2/token` | perm `use oauth2 server`, `_auth: [cookie, basic_auth]` | Token endpoint. Reads client credentials (HTTP Basic, POST body, or JWT `assertion`), delegates to library `handleTokenRequest()`. |
| `oauth2_server.tokens` `/oauth2/tokens/{oauth2_server_token}` | perm `use oauth2 server` | Returns the access-token record as JSON (minus `server`), 404 if missing/expired. Introspection of a token string you already hold. |
| `oauth2_server.userinfo` `/oauth2/UserInfo` | perm `use oauth2 server`, `_auth: [oauth2]` | OpenID Connect UserInfo; claims from the bearer token's scopes. |
| `oauth2_server.revoke` `/oauth2/revoke` | perm `use oauth2 server` | Revoke a token (library `handleRevokeRequest`). |
| `oauth2_server.certificates` `/oauth2/certificates` | `_access: TRUE` (public) | JSON array with the current public-key X.509 certificate. |
| `oauth2_server.jwk` `/oauth2/jwk` | `_access: TRUE` (public) | Public key in JWK format (RSA, `use: sig`, `alg: RS256`, `kid` = hmac of cert id + hash salt). |

Client credentials resolution order (`Utility::getClientCredentials`): HTTP Basic (`PHP_AUTH_USER`/`PW`)
→ POST `client_id`/`client_secret` → JWT `assertion` (`iss` = client_id). Servers are looked up via the
client; a disabled server 404s (`startServer()` returns NULL for disabled servers).

## The `oauth2` authentication provider

Service `authentication.oauth2` (`OAuth2DrupalAuthProvider`, `provider_id: oauth2`, priority 100) lets any
route accept `Authorization: Bearer <access_token>`. Add it to a route:

```yaml
my_module.api:
  path: '/my/api'
  defaults: { _controller: '\Drupal\my_module\Controller\Api::data' }
  options:
    _auth: ['oauth2']
  requirements:
    _permission: 'access content'   # or your own
```

A `page_cache_request_policy` (`DisallowOauth2Requests`) disables the anonymous page cache for requests
carrying an OAuth2 bearer token so tokens are never served from cache.

## Verifying tokens/scope in custom code — `Utility::checkAccess()`

```php
use Drupal\oauth2_server\Utility;

// Returns the token array on success, or an \OAuth2\Response (error) to return as-is.
$result = Utility::checkAccess('my_server_id', 'my_scope');
if ($result instanceof \OAuth2\ResponseInterface) {
  // 401 invalid_grant / insufficient_scope — return $result.
}
else {
  $uid = $result['user_id'];       // authenticated Drupal user
  $scopes = $result['scope'];      // granted scopes (space separated)
}
```

It starts the server, extracts the bearer token from the current request, checks the token belongs to the
named server, and (if `$scope` given) enforces scope via `ScopeUtility::checkScope`.

## Storage service and entities

- `oauth2_server.storage` (`OAuth2Storage`) implements the bshaffer storage interfaces:
  client/user/token/code/refresh/JWT-bearer/public-key. Client secrets and user passwords are checked with
  the Drupal password hasher. `getUserClaims()` builds OIDC claims (`sub`, plus `email`/`profile` scope data)
  and fires the claims hooks.
- Content entities: `oauth2_server_token` (access + refresh, distinguished by `type`),
  `oauth2_server_authorization_code`, `oauth2_server_jti` (replay protection for JWT bearer).
- `OAuth2Helper` (`oauth2_server.oauth_helper`) is a thin helper over storage used by the auth provider.

## Notes

- `getStorageToken()` also accepts a JWT access token: it decodes it and looks up the embedded `id`.
- Blocked users are denied at token/refresh use (except pure `client_credentials` tokens which have no user).
