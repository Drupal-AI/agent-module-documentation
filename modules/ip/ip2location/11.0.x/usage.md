<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IP2Location identifies a visitor's geographical location (country, region, city, latitude/longitude, ISP, ZIP, time zone and more) from their IP address using a local proprietary IP2Location BIN database.
---
On every kernel request an event subscriber (`InitSubscriber`, priority default) checks the session: if no `ip2location` value is cached, it reads the admin-configured `database_path` and `cache_mode`, opens the BIN database via the `ip2location/ip2location-php` library (which you must install with Composer), looks up `\Drupal::request()->getClientIp()`, and stores the full record set as JSON in the visitor's session. Subsequent code reads it back through the procedural helper `ip2location_get_records()`, which returns a decoded object (or nothing if unavailable). A `DEV_MODE` server flag forces the lookup IP to `8.8.8.8` for local testing.

Configuration lives at `/admin/config/system/ip2location` (route `ip2location.admin_settings`, gated by `administer site configuration`). The form takes the BIN database path (described as relative to the Drupal root, e.g. `sites/default/files/IP2Location-LITE-DB11.BIN`) and a cache mode (No cache / Memory cache / Shared memory). On save it validates the path with `is_file()` and performs a test lookup of `8.8.8.8`. The module ships with an empty database; download a free LITE or commercial BIN from ip2location.com. Note the geolocation record is derived from the client IP as Drupal computes it, so behind a proxy/CDN correct client-IP/trusted-proxy configuration is required for accurate results.
---
- Install the `ip2location/ip2location-php` library via `composer require`.
- Download an IP2Location LITE or commercial BIN database.
- Set the BIN database path at `/admin/config/system/ip2location`.
- Choose a cache mode (No cache / Memory cache / Shared memory) for lookup speed.
- Read the visitor's country in custom code via `ip2location_get_records()`.
- Personalize content by visitor country or region.
- Show localized currency, language, or offers based on geolocation.
- Populate analytics with visitor country/city data.
- Restrict or redirect visitors by detected country (in your own logic).
- Display the visitor's detected city/region in a block.
- Prefill address forms with country from geolocation.
- Retrieve ISP, ASN, or usage type for a visitor.
- Use latitude/longitude to power a "near me" feature.
- Cache lookups per session to avoid repeated BIN reads.
- Force a test IP locally by setting the `DEV_MODE` server variable.
- Validate a new BIN file via the settings form's built-in `8.8.8.8` test lookup.
- Switch to Shared memory mode on high-traffic servers with sufficient RAM.
- Expose time zone or net speed data to theming.
- Feed weather-station or IDD/area codes into downstream integrations.
- Update the BIN database monthly and re-point the path.