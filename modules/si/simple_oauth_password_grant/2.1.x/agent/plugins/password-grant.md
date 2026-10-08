# The `password` Oauth2Grant plugin

The module contributes one plugin to Simple OAuth's `Oauth2Grant` plugin type (manager
`plugin.manager.oauth2_grant.processor`).

## Definition

```
@Oauth2Grant(
  id = "password",
  label = @Translation("Password")
)
```

Class: `Drupal\simple_oauth_password_grant\Plugin\Oauth2Grant\Password`, extends
`Drupal\simple_oauth\Plugin\Oauth2GrantBase`, implements `ContainerFactoryPluginInterface`.

## What it builds

`getGrantType(Consumer $client)` returns a configured PHP League
`League\OAuth2\Server\Grant\PasswordGrant`, constructed with:

- the module's user repository — `simple_oauth_password_grant.repositories.user`
  (implements `UserRepositoryInterface`), and
- Simple OAuth's refresh-token repository — `simple_oauth.repositories.refresh_token`.

It then sets the grant's **refresh token TTL** from the consumer's `refresh_token_expiration`
field (falling back to `1209600` seconds — 14 days — when empty), as a `\DateInterval` of
`PT{seconds}S`.

## How Simple OAuth uses it

When a token request arrives with `grant_type=password`, Simple OAuth resolves this plugin for
any consumer whose `grant_types` include `password`, calls `getGrantType()`, and lets the League
server run the standard password-credentials flow. Credential validation is delegated to the
user repository (see [api/user-repository.md](../api/user-repository.md)).

There are no other plugins in this module; the id to enable everywhere is simply `password`.
