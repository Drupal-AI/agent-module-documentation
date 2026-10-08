# Plugins — `local_private` GeoLocator

This module does **not** define a plugin type; it **implements** one GeoLocator plugin for the
**geoip** module's `GeoLocator` plugin system.

## `LocalPrivate` (id `local_private`)
`src/Plugin/GeoLocator/LocalPrivate.php`:

```php
#[GeoLocator(id: "local_private", label: "Local dataset (private filesystem)", ...)]
class LocalPrivate extends \Drupal\geoip\Plugin\GeoLocator\Local {
  protected $scheme = 'private';
}
```

- Subclasses geoip's `Local` plugin and only overrides the storage `$scheme` from `public` to
  `private`, so it reads the MaxMind `.mmdb` from `private://GeoLite2-Country.mmdb` — the exact
  path this module writes to. All lookup logic is inherited from geoip's `Local`.
- Weight `0`, so it does not automatically outrank other locators; you must select it.

## Selecting it as the active locator
On `/admin/config/system/geoip` choose **Local dataset (private filesystem)**. Or via config:
```
drush cset geoip.geolocation plugin_id local_private -y
```
When `geoip.geolocation.plugin_id` is `local_private`, this module's `hook_requirements`
override reports the `private://` database (and warns if it is >1 month old) instead of geoip's
default `public://` check.

## Consuming geolocation
Downstream code uses the geoip module's geolocator service exactly as before — this plugin just
changes where the database file lives. Nothing here is geoip_autoupdate-specific at call time.
