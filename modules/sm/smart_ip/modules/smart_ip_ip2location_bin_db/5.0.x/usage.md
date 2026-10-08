Smart IP IP2Location binary database is a Smart IP data source that geolocates visitors offline against a downloaded IP2Location BIN database using the `ip2location/ip2location-php` library.

---

This submodule registers the Smart IP data source `ip2location_bin_db`. Enable it and set `smart_ip.settings:data_source` to `ip2location_bin_db` to use it. Its settings live in `smart_ip_ip2location_bin_db.settings`: `version` (`lite` for the free IP2Location LITE database or the commercial edition), `edition` (the BIN code, e.g. `DB11`), `token` (IP2Location download token), `db_auto_update` (refresh the BIN on cron, default FALSE), `caching_method` (`no_cache`, shared memory, or file caching mode passed to the reader), and `bin_file_custom_path` (use a BIN file you manage). It implements the data-source interface via an event subscriber (`SmartIpEventSubscriber` extending `SmartIpEventSubscriberBase`): `processQuery()` reads the visitor's IP against the BIN file and fills the location (country, region, city, postal code, latitude/longitude, time zone); `manualUpdate()`/`cronRun()` (via `DatabaseFileUtility`) download and refresh the database. Lookups are offline, fast and private. Requires the `ip2location/ip2location-php` library (already required by the Smart IP project's composer.json).

---

- Geolocate visitors offline using a local IP2Location BIN database.
- Use the free IP2Location LITE database (`version: lite`).
- Use a commercial IP2Location edition/BIN code (e.g. `DB11`) for more fields/accuracy.
- Provide an IP2Location download `token` so Smart IP can fetch the BIN automatically.
- Auto-update the BIN database on cron (`db_auto_update: true`).
- Point Smart IP at a BIN file you manage yourself via `bin_file_custom_path`.
- Tune reader performance with a `caching_method` (no cache / shared memory / file cache).
- Get country, region, city, postal code, latitude/longitude and time zone from an IP.
- Keep geolocation private (all lookups happen locally, no per-request API call).
- Serve high-traffic sites where per-request web-service lookups would be too costly.
- Trigger a manual BIN download/update from the Smart IP admin form.
- Feed the `SmartIp::query()` API with offline IP2Location data.
- Back a country-based block visibility rule with IP2Location data.
- Combine with Smart IP's role/page/excluded-IP controls for targeted geolocation.
- Use IP2Location as an alternative to MaxMind for offline geolocation.
- Switch a site from a web-service source to an offline BIN database for performance/privacy.
- Choose the BIN edition that includes the location fields your site needs.
