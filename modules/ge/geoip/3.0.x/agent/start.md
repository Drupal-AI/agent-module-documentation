# GeoIP — agent index

API module that geolocates an IP to an ISO country code via pluggable **GeoLocator** plugins.
Ships two: `cdn` (reads a CDN country header) and `local` (MaxMind GeoLite2 `.mmdb` via
`geoip2/geoip2`). No permissions.yml (settings form uses core `administer site configuration`),
no Drush. Config `geoip.geolocation` selects the active plugin. **Default plugin: `cdn`.**

- **Select the active plugin + debug, config keys, database install, requirements** →
  [configure/settings.md](configure/settings.md)
- **The `geoip.geolocation` service and `geolocate()` — call it from code** →
  [api/geolocation.md](api/geolocation.md)
- **The `geolocator` plugin type: write your own GeoLocator** →
  [plugins/geolocator.md](plugins/geolocator.md)

Key facts:
- Service `geoip.geolocation` (class `GeoLocation`) → `geolocate($ip): ?string`; results cached
  PERMANENT per IP, cache tag `geoip`.
- Plugin manager `plugin.manager.geolocator` (`GeoLocatorManager`), dir `Plugin/GeoLocator`,
  annotation `Drupal\geoip\Annotation\GeoLocator`, interface `GeoLocatorInterface`, base
  `GeoLocatorBase`, alter hook `hook_geolocator_alter`.
- Config `geoip.geolocation`: `plugin_id` (default `cdn`), `debug` (bool). Ships via
  `config/install/geoip.geolocation.yml`.
- Route `geoip.configure` → `/admin/config/system/geoip` (perm `administer site configuration`).
- Requires Composer lib `geoip2/geoip2:~2.0`; Local plugin reads `public://GeoLite2-*.mmdb`.
