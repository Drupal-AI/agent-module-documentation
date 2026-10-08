Smart IP determines a visitor's geographical location (country, region, city, postal code, latitude/longitude and time zone) from their IP address, caches it in the session and optionally on the user profile, and exposes it to code, blocks and other modules. The actual lookup is delegated to a pluggable "data source" submodule (MaxMind, IP2Location, IPInfoDB, Abstract, or a device/W3C source).

---

Smart IP itself is the framework; it ships no lookup database. You enable one **data source** submodule and select it as `smart_ip.settings:data_source`. On each request, `GeolocateUserSubscriber` geolocates configured roles (`roles_to_geolocate`) and stores the result; `SmartIp::query($ip)` is the core entry point — it builds a `SmartIpLocation` (service `smart_ip.smart_ip_location`), dispatches `SmartIpEvents::QUERY_IP` so the active data source populates it, runs `updateFields()` (deriving country/region names, time zone, EU flag), then dispatches `DATA_ACQUIRED` so other modules can alter the result. Data source modules don't use a plugin manager: they extend `SmartIpEventSubscriberBase` (which implements `SmartIpDataSourceInterface` + `EventSubscriberInterface`), declare a `sourceId()` and `configName()`, and subscribe to Smart IP's events to add their own admin-form section, process the query, and (for database sources) handle manual/cron database updates. Configuration lives in `smart_ip.settings` (roles to geolocate, debug mode + debug IP per role, allowed pages, excluded IPs, don't-save-for-EU, time-zone format) and is edited at `/admin/config/people/smart_ip` (permission `administer smart_ip`). Results are cached per-IP in a static and in the session; `SmartIp::updateUserLocation()` can persist location on the user entity. A `UserCountry` condition plugin enables country-based block/visibility rules. The two `*_bin_db` sources need the external `geoip2/geoip2` / `ip2location/ip2location-php` libraries (already required by the module's composer.json).

---

- Detect a visitor's country from their IP address and act on it in code via `SmartIp::query()`.
- Show or hide a block by visitor country using the Smart IP "User country" condition plugin.
- Redirect or localize content based on the visitor's detected region or city.
- Pre-fill a country/region field on a form from the visitor's geolocation.
- Store each user's location on their profile at registration (`save_user_location_creation`).
- Geolocate only specific roles (e.g. authenticated users) via `roles_to_geolocate`.
- Exclude internal or office IP ranges from lookup with `excluded_ips`.
- Restrict geolocation to specific pages via `allowed_pages`.
- Avoid saving location data for EU visitors for privacy/GDPR reasons (`eu_visitor_dont_save`).
- Debug geolocation by forcing a fake IP per role (`roles_in_debug_mode` + `roles_in_debug_mode_ip`).
- Choose the time-zone representation (identifier vs offset) with `timezone_format`.
- Use MaxMind GeoIP2 binary database as the lookup source (offline, auto-updating).
- Use IP2Location binary database as the lookup source.
- Use MaxMind GeoIP2 Precision web service for on-demand lookups.
- Use the IPInfoDB or Abstract web service as a keyed API lookup source.
- Get the visitor's latitude/longitude for maps or distance calculations.
- Get the visitor's time zone to display localized times.
- Read a full location array (country, countryCode, region, city, zip, lat/long, timeZone, isEuCountry).
- Persist and retrieve the current visitor's location in the session (`SmartIp::getSession()`).
- Let other modules alter the geolocation result by subscribing to `smart_ip.data_acquired`.
- Add a brand-new geolocation provider by writing a data source event subscriber.
- Trigger a manual database update for binary-database sources from the admin form.
- Refresh binary geolocation databases automatically on cron.
- Detect and special-case EU-country visitors via the `isEuCountry` flag.
- Provide client-device (W3C Geolocation API) coordinates via the Device Geolocation submodule.
- Build geo-targeted marketing or compliance features (cookie banners, currency, language hints).
