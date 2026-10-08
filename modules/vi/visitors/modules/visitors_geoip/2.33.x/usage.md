<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Visitors GeoIP is a submodule of Visitors that adds **geolocation** to the analytics: it resolves each logged visit's IP to a country / region / city using a MaxMind GeoLite2 database and adds location reports.

---

The submodule wraps the `geoip2/geoip2` library in a `visitors_geoip.lookup` service (`GeoIpService`) that opens the MaxMind **GeoLite2 City** database (`.mmdb`) and resolves an IP to a location (`city($ip)`, `metadata()`, plus `hasLibrary()`/`hasExtension()` capability checks). Two config values live in **`visitors_geoip.settings`**: `geoip_path` (filesystem location of the MaxMind database) and `license` (your MaxMind license key, used to download it). Its settings form is at `/admin/config/system/visitors/geoip` (route `visitors_geoip.settings`), and a rebuild form at `/admin/config/system/visitors/rebuild-location` recomputes location for already-logged hits. It exposes new report routes under the main Visitors reports — `/visitors/location/region/{country}/{region}` and `/visitors/location/city/{country}/{region}/{city}` (`ReportController`, permission `access visitors`) — and provides a `views.view.visitors_geoip` view. Two Drush commands support it: `visitors:download:city` downloads/updates the GeoLite2 City database (needs the license key) and `visitors:rebuild:location` recomputes location data from IP addresses in the existing log. It depends on the parent `visitors` module and reuses its `access visitors` permission (it defines none of its own).

---

- Add country-level breakdowns to the Visitors analytics reports.
- Drill into visits by region within a country.
- Drill into visits by city.
- Resolve a visitor's IP to a location with the MaxMind GeoLite2 City database.
- Point the module at a MaxMind database file via `geoip_path`.
- Store a MaxMind license key (`license`) to enable automated database downloads.
- Download/update the GeoLite2 City database with `drush visitors:download:city`.
- Recompute location for historic log rows with `drush visitors:rebuild:location`.
- Rebuild locations from the admin UI at `/admin/config/system/visitors/rebuild-location`.
- Check whether the geoip2 PHP library is available (`GeoIpService::hasLibrary`).
- Check whether the maxminddb PHP extension is present (`hasExtension`).
- Build custom geo reports on the provided `visitors_geoip` view.
- See where your traffic comes from geographically, self-hosted (no third-party geo API).
- Combine geo data with device/referrer reports from the parent Visitors module.
- Localize marketing decisions using on-site country/region/city stats.
- Restrict geo reports to trusted users via the parent's `access visitors` permission.
- Keep the GeoLite2 database up to date on a schedule via the download command.
- Configure a shared database path for multiple sites (`geoip_path`).
- Inspect the loaded database's metadata (`GeoIpService::metadata`).
- Report visitor cities for a specific country/region via the location routes.
