# GeoIP — agent index

API module that geolocates an IP to an ISO country code via pluggable **GeoLocator** plugins.
Ships three: `cdn` (reads a CDN country header — custom, Cloudflare, or CloudFront), `local`
(MaxMind GeoLite2 `.mmdb` via `geoip2/geoip2`), and `webservice` (MaxMind hosted GeoIP2 web
service). Config `geoip.geolocation` selects the active plugin and holds CDN/web-service settings.
Optional submodule **geolite2_update** downloads/refreshes the local database (cron + Drush).
**Default plugin: `cdn`.**

- **Select the active plugin + custom header + web-service creds + debug, config keys, database
  install, requirements** → [configure/settings.md](configure/settings.md)
- **The geolite2_update submodule: auto-download the MaxMind DB (cron / `drush geolite2:update`)**
  → [configure/geolite2-update.md](configure/geolite2-update.md)
- **The `geoip.geolocation` service and `geolocate()` — call it from code, cache context** →
  [api/geolocation.md](api/geolocation.md)
- **The `geolocator` plugin type: write your own GeoLocator (attribute-based)** →
  [plugins/geolocator.md](plugins/geolocator.md)

Key facts:
- Service `geoip.geolocation` (class `GeoLocation`) → `geolocate(string $ip): ?string`; results
  cached PERMANENT per IP, cache tag `geoip`. Cache context `geoip_country`.
- Plugin manager `plugin.manager.geolocator` (`GeoLocatorManager`), dir `Plugin/GeoLocator`,
  attribute `Drupal\geoip\Attribute\GeoLocator` (annotation `Drupal\geoip\Annotation\GeoLocator`
  deprecated in 3.1.0, removed in 3.2.0), interface `GeoLocatorInterface` (now typed:
  `geolocate(string): ?string`), base `GeoLocatorBase`, alter hook `hook_geolocator_alter`.
- Config `geoip.geolocation`: `plugin_id` (default `cdn`), `debug` (bool), `account_id`,
  `license_key` (web service), `custom_header` (CDN). Ships via `config/install/geoip.geolocation.yml`.
- Route `geoip.configure` → `/admin/config/system/geoip` (perm `administer site configuration`).
- Requires Composer lib `geoip2/geoip2:^3` (was `~2.0`); PHP >=8.1; core `^10.3 || ^11`.
- Local plugin reads `public://GeoLite2-{City,Country}.mmdb`; geolite2_update writes them there.
