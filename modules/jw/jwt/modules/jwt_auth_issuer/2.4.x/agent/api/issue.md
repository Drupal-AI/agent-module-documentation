<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Issuing tokens

## The `jwt/token` endpoint

| | |
|---|---|
| Route | `jwt_auth_issuer.jwt_auth_issuer_controller_generateToken` |
| Path | `jwt/token` |
| Controller | `JwtAuthIssuerController::tokenResponse` |
| Requirement | `_user_is_logged_in: TRUE` |
| Auth providers | `jwt_auth`, `basic_auth`, `cookie` |

Call it as an authenticated user and it returns a signed JWT for that account. Typical
bootstrap flow for a decoupled client:

```bash
# Authenticate with basic auth to get a token, then use the token as a Bearer credential.
curl -u user:pass https://example.com/jwt/token
# -> the response contains a signed JWT
curl -H 'Authorization: Bearer <that-token>' https://example.com/api/some-resource
```

The token is signed with the key configured on the base module (`jwt.config` `key_id`). If no
key is configured, the transcoder returns nothing to sign.

## The GENERATE subscriber (what claims tokens get)

`jwt_auth_issuer.subscriber` (`JwtAuthIssuerSubscriber`, arg `@current_user`) listens on
`JwtAuthEvents::GENERATE` and stamps the current user's id as the nested `drupal.uid` claim, so
issued tokens are consumable by `jwt_auth_consumer`. Add your own `GENERATE` subscriber to add
more claims (see the base module's `hooks/events.md`).

## Issuing in code

```php
/** @var \Drupal\jwt\Authentication\Provider\JwtAuth $auth */
$auth = \Drupal::service('jwt.authentication.jwt');
$raw = $auth->generateToken();   // dispatches GENERATE (adds drupal.uid), then encodes
```

## Login-response token

`jwt_auth_issuer.login_listener` (`JwtLoginSubscriber`) adds a `jwt` token to the core
user-login REST response when `jwt_auth_issuer.config` `jwt_in_login_response` is TRUE — see
[configure/settings.md](../configure/settings.md).
