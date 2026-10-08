<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GoogleAuthManager service & Network plugin

## Network plugin

`\Drupal\social_auth_google\Plugin\Network\GoogleAuth` — `@Network(id = "social_auth_google",
social_network = "Google")`, `config_id = "social_auth_google.settings"`. It builds the
`league/oauth2-google` `Google` provider from the configured client id/secret and redirect
URI. The Social Auth framework discovers it as the "Google" provider; you rarely instantiate
it directly.

## `social_auth_google.manager` service

`\Drupal\social_auth_google\GoogleAuthManager` (args: config.factory, logger.factory,
request_stack). Methods:

| Method | Purpose |
|---|---|
| `getAuthorizationUrl(): string` | The Google OAuth authorization URL to redirect the user to (with the always-on `openid`/`email`/`profile` scopes plus configured extras). |
| `getState(): string` | The OAuth CSRF `state` value for the current flow. |
| `authenticate(): void` | Exchange the returned code for an access token (called on callback). |
| `getUserInfo(): SocialAuthUserInterface` | The authenticated Google user's profile (id, name, email, picture) as a Social Auth user object. |
| `requestEndPoint(string $method, string $path, ?string $domain = NULL, array $options = []): mixed` | Call an arbitrary Google API endpoint with the access token. |

These are driven by the base Social Auth controller during login; call them yourself only for
custom flows (e.g. requesting extra Google API data after authentication):

```php
$manager = \Drupal::service('social_auth_google.manager');
$url = $manager->getAuthorizationUrl();   // send the user here
// …on callback the framework calls authenticate() then getUserInfo().
```

The login button, redirect route and callback are all provided by the base `social_auth`
module (this module supplies only the Google-specific manager + network plugin). Configure
credentials first: [../configure/settings.md](../configure/settings.md).
