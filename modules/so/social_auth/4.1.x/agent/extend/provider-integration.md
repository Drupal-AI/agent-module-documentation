<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build a provider integration

A concrete provider (e.g. "Sign in with Acme") ships as its own module `social_auth_acme`
that plugs into Social Auth. This is the module's main extension point. (Most common providers
already exist as contrib `social_auth_*` modules — check before writing one.)

## Pieces you implement

1. **A Social API Network plugin** — a class in `src/Plugin/Network/` extending Social Auth's
   `Drupal\social_auth\Plugin\Network\NetworkBase` (which implements `NetworkInterface`). It
   is discovered by social_api's `plugin.network.manager`. It declares the provider's OAuth2
   client class and auth-manager class and builds the SDK client from the stored
   `client_id`/`client_secret`. Interface highlights (`NetworkInterface`):
   `getRedirectUrl()`, `getCallbackUrl()`, `getSettingsFormUrl()`, `getProviderLogoPath()`,
   `getSocialNetwork()`, `getProviderClassName()`, `getAuthManagerClassName()`.

2. **An OAuth2 manager** implementing
   `Drupal\social_auth\AuthManager\OAuth2ManagerInterface` (extend
   `Drupal\social_api\AuthManager\OAuth2Manager`). Implement:
   `getScopes(): string`, `getEndPoints(): string`,
   `getExtraDetails(string $method = 'GET', ?string $domain = NULL): ?array`,
   `requestEndPoint(string $method, string $path, ?string $domain = NULL, array $options = []): mixed`,
   plus the inherited `authenticate()`, `getAccessToken()`, `getUserInfo()`, `getAuthorizationUrl()`.

3. **A controller** extending `Drupal\social_auth\Controller\OAuth2ControllerBase` with your
   provider's `redirectToProvider()` / `callback()` wiring, then routes
   `user/login/acme` and `user/login/acme/callback` pointing at it (mirror
   `social_auth.routing.yml`).

## The flow you get for free

`OAuth2ControllerBase::redirectToProvider()` sends the user to the provider
(`user/login/{network}`); the provider returns to `user/login/{network}/callback`, where
`callback()` exchanges the code, then your controller calls the shared services:

```php
// after fetching the provider profile into a SocialAuthUser:
$this->userAuthenticator->setDestination(...);
return $this->userAuthenticator->authenticateUser($social_auth_user);
```

`UserAuthenticator` then applies site policy (`user_allowed`, `disable_admin_login`,
`disabled_roles`), links/creates the account via `UserManager`, stores the `social_auth`
profile, and logs the user in — see [../api/services.md](../api/services.md).

## Register credentials

Your Network plugin reads `client_id`/`client_secret`/`scopes`/`endpoints` from the config
object `"<network_id>.settings"`, which the shared `SocialAuthSettingsForm` writes at
`/admin/config/social-api/social-auth/<network>`. You supply those by registering an OAuth app
with the provider (**external dependency**).
