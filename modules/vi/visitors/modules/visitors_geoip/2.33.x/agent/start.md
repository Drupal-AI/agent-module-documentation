<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Visitors GeoIP — agent index

Submodule of **Visitors**. Adds geolocation (country / region / city) to the analytics by
resolving logged IPs against a MaxMind **GeoLite2 City** database (`geoip2/geoip2`). Depends on
`visitors`; reuses its `access visitors` permission (defines none of its own).

Key facts:
- `configure` route = `visitors_geoip.settings` → `/admin/config/system/visitors/geoip`.
- Config object **`visitors_geoip.settings`**: `geoip_path` (path to the `.mmdb` database),
  `license` (MaxMind license key).
- Service `visitors_geoip.lookup` (`GeoIpService`): `city($ip)`, `metadata()`, `hasLibrary()`,
  `hasExtension()`.
- Report routes: `/visitors/location/region/{country}/{region}`,
  `/visitors/location/city/{country}/{region}/{city}` (perm `access visitors`).
- Drush: `visitors:download:city` (download DB), `visitors:rebuild:location` (recompute geo).

- **Settings + rebuild/download + reports** → [configure/settings.md](configure/settings.md)
- **Drush commands** → [drush/commands.md](drush/commands.md)
