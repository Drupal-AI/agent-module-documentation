Smart IP MaxMind GeoIP2 binary database is a Smart IP data source that looks up a visitor's location offline against a downloaded MaxMind GeoIP2/GeoLite2 `.mmdb` binary database using the `geoip2/geoip2` PHP library.

---

This submodule registers the Smart IP data source `maxmind_geoip2_bin_db`. Enable it, then set `smart_ip.settings:data_source` to `maxmind_geoip2_bin_db` to make Smart IP use it. Its own settings live in `smart_ip_maxmind_geoip2_bin_db.settings`: `version` (`lite` for free GeoLite2 or the commercial edition), `edition` (`city` or `country`), `user_account` and `license_key` (MaxMind credentials used to download the database), `db_auto_update` (refresh the `.mmdb` on cron, default TRUE), and `bin_file_custom_path` (use a database file you manage yourself). It implements the Smart IP data-source interface via an event subscriber (`SmartIpEventSubscriber` extending `SmartIpEventSubscriberBase`): `processQuery()` reads the visitor's IP against the binary database and fills the location (country, region, city, postal code, latitude/longitude, time zone); `manualUpdate()`/`cronRun()` download and refresh the database (via `DatabaseFileUtility`). Because it is offline, lookups are fast and private (no per-request API call). It requires the `geoip2/geoip2` library (already required by the Smart IP project's composer.json).

---

- Geolocate visitors offline using a local MaxMind GeoIP2 `.mmdb` database (no per-request API call).
- Use the free MaxMind GeoLite2 database (`version: lite`) for country/city lookups.
- Use a commercial MaxMind GeoIP2 database edition for higher accuracy.
- Choose city-level (`edition: city`) or country-level (`edition: country`) resolution.
- Provide MaxMind account id + license key so Smart IP can download the database automatically.
- Auto-update the binary database on cron (`db_auto_update: true`).
- Point Smart IP at a `.mmdb` file you manage yourself via `bin_file_custom_path`.
- Get country, region, city, postal code, latitude/longitude and time zone from an IP.
- Keep geolocation private (all lookups happen locally, no third-party call per request).
- Serve high-traffic sites where per-request web-service lookups would be too slow or costly.
- Trigger a manual database download/update from the Smart IP admin form.
- Refresh to the latest GeoLite2/GeoIP2 data periodically without manual intervention.
- Combine with Smart IP's role/page/excluded-IP controls for targeted geolocation.
- Feed the `SmartIp::query()` API with offline MaxMind data.
- Back a country-based block visibility rule (Smart IP "User country" condition) with MaxMind data.
- Use as the primary source on sites that must avoid sending visitor IPs to external services.
- Switch a site from a web-service source to an offline binary database for performance.
