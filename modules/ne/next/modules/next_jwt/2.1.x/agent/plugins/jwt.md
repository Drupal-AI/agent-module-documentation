<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js JWT — the jwt preview URL generator

next_jwt **implements** next's `preview_url_generator` plugin type (it defines no new plugin type).

## The plugin

```php
// src/Plugin/Next/PreviewUrlGenerator/Jwt.php
/**
 * @PreviewUrlGenerator(
 *   id = "jwt",
 *   label = "JSON Web Tokens",
 *   description = "This plugin generates preview URL using JSON Web Tokens.
 *     You can use this for user-based access control."
 * )
 */
class Jwt extends ConfigurablePreviewUrlGeneratorBase { … }
```

vs the default `simple_oauth` generator (role/scope based), `jwt` is **user based**: the generated
URL carries a JWT and access is decided by the token's user/roles.

## Selecting it

There is no admin form on this submodule; switch the whole Next.js integration to it via
`next.settings`:

```bash
drush cset next.settings preview_url_generator jwt -y
```

Or in code:

```php
\Drupal::configFactory()->getEditable('next.settings')
  ->set('preview_url_generator', 'jwt')
  ->set('preview_url_generator_configuration', [
    'secret_expiration' => 30,        // minutes
    'access_token_expiration' => 300, // seconds
  ])->save();
```

Config schema `next.preview_url_generator.configuration.jwt` → `{ secret_expiration: int,
access_token_expiration: int }`. Confirm the active generator:

```php
\Drupal::service('next.settings.manager')->getPreviewUrlGenerator()->getId(); // 'jwt'
```

## Route subscriber

`Drupal\next_jwt\Routing\RouteSubscriber::alterRoutes()` adds the `jwt_auth` authentication provider
to two routes so the Next.js app's JWT-authenticated requests work:

- `decoupled_router.path_translation`
- `subrequests.front-controller`

(It appends `jwt_auth` to each route's `_auth` option.)

## Event subscriber

`Drupal\next_jwt\EventSubscriber\JwtEventSubscriber` (args `@current_user`,
`@next.settings.manager`) subscribes to the `jwt` module's generate event to add the claims needed
for preview when a token is minted.

## Dependencies

`jwt` and `jwt_auth_consumer` must be enabled (they provide the JWT auth + key configuration). Access
control for preview then follows the JWT's user rather than OAuth scopes.
