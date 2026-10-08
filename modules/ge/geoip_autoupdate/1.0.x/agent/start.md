# GeoIP Auto-Update — agent index

Auto-downloads the MaxMind GeoLite2-Country `.mmdb` on cron into `private://` and provides a
`local_private` GeoLocator plugin for the **geoip** module (hard dependency). Config UI at
`/admin/config/system/geoip/autoupdate` (route `geoip_autoupdate.settings`, permission
`administer site configuration`). No own permissions, no Drush. Provides a config schema.

- **Settings form, config keys, cron/HEAD/download flow, "Download now"** →
  [configure/settings.md](configure/settings.md)
- **The `local_private` GeoLocator plugin (private:// scheme) and selecting it** →
  [plugins/geolocator.md](plugins/geolocator.md)
- **`geoip_autoupdate.updater` service: runUpdate / forceUpdate / getLastModified** →
  [api/updater.md](api/updater.md)

Key facts:
- Config object `geoip_autoupdate.settings`: `account_id`, `license_key` (both empty on install).
- Download URL is a fixed constant `https://download.maxmind.com/geoip/databases/GeoLite2-Country/download?suffix=tar.gz`; auth is HTTP Basic (`account_id`:`license_key`), redirects followed.
- Freshness gate: state `geoip_autoupdate.last_modified` vs the HEAD `Last-Modified` header.
- Database installed to `private://GeoLite2-Country.mmdb`; requires `$settings['file_private_path']` and the PHP `phar` extension.
- `hook_requirements` overrides geoip's `geoip_local_database` check to look at `private://` (only when the active GeoLocator plugin is `local_private`).
