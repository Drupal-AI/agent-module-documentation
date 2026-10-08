<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `commerce_square.connect` service

Service id **`commerce_square.connect`** → class `Drupal\commerce_square\Connect`, constructed
with `@config.factory` and `@state`. It centralises access to Square credentials and builds a
configured API client. Modes use the SDK constants `Square\Environment::SANDBOX` (`'sandbox'`)
and `Square\Environment::PRODUCTION` (`'production'`).

```php
$connect = \Drupal::service('commerce_square.connect');
```

## Methods

| Method | Returns | Source of value |
|---|---|---|
| `getAppName()` | string | `commerce_square.settings:app_name` |
| `getAppSecret()` | string | `commerce_square.settings:app_secret` |
| `getAppId($mode)` | string | production → `production_app_id`; else `sandbox_app_id` |
| `getAccessToken($mode)` | string | production → state `commerce_square.production_access_token`; else config `sandbox_access_token` |
| `getRefreshToken($mode)` | string | production → state `commerce_square.production_refresh_token`; else `''` |
| `getAccessTokenExpiration($mode)` | int | production → state `…_access_token_expiry`; else `-1` (sandbox) |
| `getClient($mode)` | `Square\SquareClient` | new client with the mode's access token + environment |

Note the asymmetry: **sandbox** credentials come from config; **production** access/refresh
tokens come from Drupal state (populated by the OAuth flow), while the production *app id*
still comes from config.

## Building a client

```php
use Square\Environment;

$client = \Drupal::service('commerce_square.connect')->getClient(Environment::SANDBOX);
$locations = $client->getLocationsApi()->listLocations();   // network call to Square
```

## Related classes

- `src/ErrorHelper.php` — converts `Square\Exceptions\ApiException` into Commerce
  `HardDeclineException` / `InvalidRequestException` (`ErrorHelper::convertException()`).
- `src/IntegrationChargeRequest.php` — helper for building charge requests in tests.

There are no hooks or events defined by this module. `commerce_square.post_update.php` holds
post-update hooks that migrate older configuration layouts.
