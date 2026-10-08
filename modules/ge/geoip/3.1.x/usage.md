GeoIP is a small API module that geolocates a visitor's IP address to a country code through pluggable **GeoLocator** plugins. It ships three: **CDN** (reads a country header set by Cloudflare / Amazon CloudFront, or a custom header you name), **Local** (queries a MaxMind GeoLite2 `.mmdb` database via the `geoip2/geoip2` library), and **Webservice** (queries the MaxMind GeoIP2 web service). An optional **GeoLite2 Database Update** submodule downloads and refreshes the Local database automatically.

---

The module defines a `geolocator` plugin type (PHP attribute `#[GeoLocator]`, deprecated annotation
`@GeoLocator` still discovered, manager `plugin.manager.geolocator`, base `GeoLocatorBase`) and a
`geoip.geolocation` service wrapping the currently-selected plugin. You call
`\Drupal::service('geoip.geolocation')->geolocate($ip)` to get an ISO country code (or NULL);
results are cached permanently per IP under cache tag `geoip`. A settings form at
`/admin/config/system/geoip` (`geoip.configure`, gated by the core `administer site configuration`
permission) picks the active plugin, sets the CDN custom header, the web-service credentials, and a
debug log, and offers an AJAX manual IP lookup. The choice persists in `geoip.geolocation` config
(`plugin_id`, `debug`, `account_id`, `license_key`, `custom_header`). The **CDN** plugin returns the
configured `custom_header` value first (for Fastly/Varnish/other CDNs), then `HTTP_CF_IPCOUNTRY`
(Cloudflare), then `HTTP_CLOUDFRONT_VIEWER_COUNTRY` (CloudFront) from the request. The **Local**
plugin looks for `GeoLite2-City.mmdb` then `GeoLite2-Country.mmdb` in the public files directory and
returns `country->isoCode`; it needs the MaxMind database file placed manually (or via the update
submodule) and the `geoip2/geoip2` Composer library. The **Webservice** plugin queries MaxMind's
hosted GeoIP2 web service using the account ID + license key. `hook_requirements` reports whether a
local database is present and warns if it is over a month old. A `geoip_country` cache context lets
render arrays / views vary by the visitor's country. The module itself only provides the lookup API —
you wire the country code into your own access, redirect, or personalization logic.
**Default shipped plugin is `cdn`.**

---

- Look up the country code for the current visitor's IP address programmatically.
- Geolocate an arbitrary IP address to an ISO country code from custom code.
- Read a Cloudflare-provided country (`CF-IPCountry`) without your own database.
- Read an Amazon CloudFront viewer country header.
- Read a custom country header set by Fastly, Varnish, or another reverse proxy.
- Use a self-hosted MaxMind GeoLite2 country/city database for offline geolocation.
- Query MaxMind's hosted GeoIP2 web service instead of shipping a database.
- Auto-download and refresh the GeoLite2 database on cron or via Drush (`geolite2:update`).
- Choose which geolocation source is active site-wide from an admin form.
- Cache geolocation results per IP to avoid repeated database/header/service lookups.
- Vary rendered output / views by country with the `geoip_country` cache context.
- Drive country-based content personalization (e.g. show region-specific blocks).
- Feed a country code into an access or redirect decision in a custom module or event subscriber.
- Pre-select a country/currency/language based on the visitor's location.
- Add geographic context to analytics or logging.
- Provide a country signal to a consent/GDPR or tax-calculation flow.
- Implement country allow/deny logic on top of the returned code.
- Write a custom GeoLocator plugin for another CDN or geolocation service.
- Extend the Local plugin's file scheme (e.g. private) by subclassing it.
- Enable a debug log channel to trace how each IP was resolved.
- Detect a missing or stale MaxMind database via the status report.
- Swap between CDN, local, and web-service geolocation without changing calling code.
- Test the active plugin with the settings form's manual IP lookup.
