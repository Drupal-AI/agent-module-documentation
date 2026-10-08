# The `geolocator` plugin type

GeoIP defines a plugin type so you can add a geolocation source (another CDN, a SaaS API, a
custom header). Implement `geolocate(string $ip_address): ?string` returning an ISO country code.

## Plugin infrastructure

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.geolocator` (`Drupal\geoip\GeoLocatorManager`) |
| Plugin directory | `src/Plugin/GeoLocator/` |
| Attribute | `Drupal\geoip\Attribute\GeoLocator` (`id`, `label`, `description`, `weight`, `deriver`) — `label`/`description` are `TranslatableMarkup` |
| Annotation (deprecated) | `Drupal\geoip\Annotation\GeoLocator` — deprecated in 3.1.0, removed in 3.2.0; still discovered, gives plain strings |
| Interface | `Drupal\geoip\Plugin\GeoLocator\GeoLocatorInterface` |
| Base class | `Drupal\geoip\Plugin\GeoLocator\GeoLocatorBase` |
| Alter hook | `hook_geolocator_alter(&$definitions)` |
| Discovery cache | bin `cache.discovery`, tag `geoip` |

**3.1 breaking change — `GeoLocatorInterface` now declares return types:**
`getId(): string`, `getLabel(): string|TranslatableMarkup`,
`getDescription(): string|TranslatableMarkup`, `geolocate(string $ip_address): ?string`.
Plugins implementing the interface directly must add `: ?string` to `geolocate()` (parameter type
may stay untyped), and the getter return types if they don't extend `GeoLocatorBase`. Plugins
extending `GeoLocatorBase` inherit the getters and only implement `geolocate()`. Attribute-based
plugins expose `label`/`description` as `TranslatableMarkup`, so code comparing them with
`is_string()` / `===` must handle that (annotation plugins still give strings — hence the union).

`GeoLocatorBase` implements `ContainerFactoryPluginInterface`, injects `config.factory`
(exposed as `$this->geoIpConfig` = the `geoip.geolocation` config) and a `geoip` logger
(`$this->logger`), and provides `getId()`, `getLabel()`, `getDescription()`. You only implement
`geolocate()`.

## Minimal example (attribute)

```php
namespace Drupal\my_module\Plugin\GeoLocator;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\geoip\Attribute\GeoLocator;
use Drupal\geoip\Plugin\GeoLocator\GeoLocatorBase;

#[GeoLocator(
  id: 'my_header',
  label: new TranslatableMarkup('Custom header'),
  description: new TranslatableMarkup('Reads X-Country from a trusted proxy'),
  weight: -20,
)]
class MyHeader extends GeoLocatorBase {

  public function geolocate(string $ip_address): ?string {
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

The built-in `Local` plugin exposes its file scheme via `getScheme()` (default `public`); override
it (e.g. return `private`) in a subclass to read the `.mmdb` from another stream wrapper.
`GeoLocatorBase` subclasses inherit config + logger injection automatically.
