# User repository & flood protection

## Service

`simple_oauth_password_grant.repositories.user` →
`Drupal\simple_oauth_password_grant\Repository\UserRepository`
(implements League `UserRepositoryInterface`).
Args: `@user.auth`, `@entity_type.manager`, `@config.factory`, `@flood`, `@request_stack`.

## `getUserEntityByUserCredentials($username, $password, $grantType, $clientEntity)`

The single method the League server calls to validate credentials during the password grant.

Flow:

1. **IP flood gate** — checks `oauth2_password_grant.failed_login_ip` against `user.flood`
   `ip_limit` / `ip_window`. If the IP is over the limit, returns a blocked response.
2. **Resolve account** — `getAccount()` looks up an **active** user (`status = 1`) by email
   first when the identifier contains `@`, otherwise by username. So `username` can be a Drupal
   username **or** the account's email.
3. **Per-user flood gate** — checks `oauth2_password_grant.failed_login_user` against `user_limit`
   / `user_window`. The identifier is the uid alone when `user.flood.uid_only` is TRUE, else
   `uid-IP`.
4. **Authenticate** — delegates to `user.auth`'s `authenticate($name, $password)`. On success it
   clears the per-user flood event and returns a `UserEntity` with the uid as identifier. On
   failure it registers a per-user failed-login event.
5. Always registers an IP-based failed-login event.

## Flood / error behaviour

- Limits come from **core's `user.flood` config** (not module config): `ip_limit`, `ip_window`,
  `user_limit`, `user_window`, `uid_only`.
- When a gate trips, it throws `League\OAuth2\Server\Exception\OAuthServerException` with error
  type `flood_user_blocked` or `flood_ip_blocked`, HTTP status **403**.
- A wrong password (not flooded) simply returns `NULL` → the League server responds with the
  standard invalid-credentials error.

## Consumer form alter

`simple_oauth_password_grant_form_consumer_form_alter()` moves the consumer's scopes selector
out of the client-credentials section into a new open **"Default scopes"** details element
(weight 2). No stored-config change beyond where scopes appear on the form.
