# Authenticating requests & endpoints

Simple OAuth registers a **global** authentication provider `oauth2` (priority 35) so any
route can accept a bearer token — clients send `Authorization: Bearer <access_token>`.

## Endpoints (from `simple_oauth.routing.yml`)
| Route / path | Purpose |
|---|---|
| `POST /oauth/token` | Exchange credentials/code/refresh token for an access token. |
| `GET,POST /oauth/authorize` | Authorization Code grant consent screen. |
| `GET,POST /oauth/userinfo` | OpenID Connect user claims (auth required). |
| `GET /oauth/jwks` | Public JWKS keys (anonymous). |
| `GET /oauth/debug` | Inspect the current token's access (perm `debug simple_oauth tokens`). |

## Requiring oauth2 on a custom route
```yaml
my_module.api:
  path: '/api/thing'
  defaults: { _controller: '\Drupal\my_module\Controller\Thing::get' }
  requirements: { _permission: 'access content' }
  options:
    _auth: ['oauth2']
```

## In code
The authenticated user for a token request is a `TokenAuthUser`
(`Drupal\simple_oauth\Authentication\TokenAuthUserInterface`) decorating the real user and
carrying the token + its scopes. Useful services:
- `simple_oauth.expired_collector` (`ExpiredCollector`) — collect/delete expired tokens.
- `simple_oauth.oauth2_scope.provider` — resolve scopes for the active provider.
- `simple_oauth.repositories.access_token` / `.refresh_token` / `.client` — league-server
  repositories bridging OAuth entities to Drupal storage.

Tokens themselves are `oauth2_token` content entities (bundles: access_token, refresh_token,
auth_code), listed at `/admin/config/people/simple_oauth/oauth2_token`. Access is enforced by
the `simple_oauth` access policy which maps granted scopes to permissions/roles.
