<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple OAuth: Fallback Header — configuration

Install and enable; it works with zero config. Tune via `settings.php` only.

```php
// Rename the fallback header (default: X-OAuth-Authorization):
$settings['simple_oauth_fallback_header'] = 'X-My-Api-Auth';

// Allow the token in an access_token GET query (RFC 6750 §2.3). Off by default.
// WARNING: tokens then appear in URLs, access logs and referers.
$settings['simple_oauth_allow_get_query'] = TRUE;
```

## Request handling (src/DisallowSimpleOauthRequests.php)
`getAccessToken()` resolution order:
1. The configured fallback header (`X-OAuth-Authorization` by default).
2. If `simple_oauth_allow_get_query` is TRUE and no header: the `access_token` GET param.

When found, the value is written to `Authorization: Bearer <token>` (any existing `Authorization` value is lost), then Simple OAuth validates it normally. No token = no change = unauthenticated.

## Coexisting with server-side HTTP auth
Implement a service provider that removes Simple OAuth's basic-auth-swap middleware so `PHP_AUTH_USER`/`PW` are not converted to OAuth client credentials:
```php
public function alter(ContainerBuilder $container): void {
  $container->removeDefinition('simple_oauth.http_middleware.basic_auth_swap');
}
```
