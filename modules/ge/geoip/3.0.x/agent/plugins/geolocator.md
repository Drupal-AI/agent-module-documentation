# The `geolocator` plugin type

GeoIP defines a plugin type so you can add a geolocation source (another CDN, a SaaS API, a
custom header). Implement `geolocate($ip): ?string` returning an ISO country code.

## Plugin infrastructure

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.geolocator` (`Drupal\geoip\GeoLocatorManager`) |
| Plugin directory | `src/Plugin/GeoLocator/` |
| Annotation | `Drupal\geoip\Annotation\GeoLocator` (`id`, `label`, `description`, `weight`) |
| Interface | `Drupal\geoip\Plugin\GeoLocator\GeoLocatorInterface` |
| Base class | `Drupal\geoip\Plugin\GeoLocator\GeoLocatorBase` |
| Alter hook | `hook_geolocator_alter(&$definitions)` |
| Discovery cache | bin `cache.discovery`, tag `geoip` |

`GeoLocatorBase` implements `ContainerFactoryPluginInterface`, injects `config.factory`
(exposed as `$this->geoIpConfig` = the `geoip.geolocation` config) and a `geoip` logger
(`$this->logger`), and provides `getId()`, `getLabel()`, `getDescription()`. You only implement
`geolocate()`.

## Minimal example

```php
namespace Drupal\my_module\Plugin\GeoLocator;

use Drupal\geoip\Plugin\GeoLocator\GeoLocatorBase;

/**
 * @GeoLocator(
 *   id = "my_header",
 *   label = "Custom header",
 *   description = "Reads X-Country from a trusted proxy",
 *   weight = -20
 * )
 */
class MyHeader extends GeoLocatorBase {

  public function geolocate($ip_address) {
    $code = $_SERVER['HTTP_X_COUNTRY'] ?? NULL;
    if (!$code && $this->geoIpConfig->get('debug')) {
      $this->logger->notice('No X-Country header for %ip', ['%ip' => $ip_address]);
    }
    return $code ?: NULL;
  }

}
```

After adding the plugin, clear cache; it appears as a selectable row on `/admin/config/system/geoip`
and can be set as `plugin_id`. Lower `weight` sorts earlier in the list. Header-reading
plugins should only read headers a trusted proxy sets.

## Subclassing an existing plugin

The built-in `Local` plugin hardcodes `getScheme()` to `public`; override it (e.g. return
`private`) in a subclass to read the `.mmdb` from another stream wrapper. `GeoLocatorBase`
subclasses inherit config + logger injection automatically.
