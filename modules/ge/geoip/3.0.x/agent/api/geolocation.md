# The geoip.geolocation service

Call this to geolocate an IP to an ISO country code. Service id `geoip.geolocation`, class
`Drupal\geoip\GeoLocation`.

```php
/** @var \Drupal\geoip\GeoLocation $geo */
$geo = \Drupal::service('geoip.geolocation');
$country = $geo->geolocate($request->getClientIp()); // 'US', 'DE', … or NULL
```

## Methods

| Method | Returns | Notes |
|---|---|---|
| `geolocate(string $ip_address)` | `string|null` | ISO country code via the active plugin, or NULL if not found. |
| `getGeoLocatorId()` | `string` | The configured `plugin_id`. |
| `getGeoLocator()` | `GeoLocatorInterface` | Instantiates the active plugin. |

## Caching

Results are cached **permanently** per IP: cache key `geolocated_ips:<ip>`, cache tag `geoip`,
in the `cache.discovery` bin, and also memoized in a static array for the request. Invalidate
with `Cache::invalidateTags(['geoip'])` (e.g. after swapping the database or plugin) to force
re-lookup. Note NULL (unresolved) results are cached too.

## Injecting instead of `\Drupal::service`

```yaml
# my_module.services.yml
my_module.thing:
  class: Drupal\my_module\Thing
  arguments: ['@geoip.geolocation']
```

The service is constructed from `plugin.manager.geolocator`, `config.factory`, and
`cache.discovery`. It reads the active plugin id from `geoip.geolocation` config at construction.

## Getting the plugin directly

```php
$manager = \Drupal::service('plugin.manager.geolocator');
$country = $manager->createInstance('local')->geolocate($ip); // bypasses the cache layer
```

The module provides only the lookup — apply the returned country code to your own access /
redirect / personalization logic.
