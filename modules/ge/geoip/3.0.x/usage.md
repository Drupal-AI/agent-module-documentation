GeoIP is a small API module that geolocates a visitor's IP address to a country code through pluggable **GeoLocator** plugins. It ships two: **CDN** (reads a country header set by Cloudflare / Amazon CloudFront) and **Local** (queries a MaxMind GeoLite2 `.mmdb` database via the `geoip2/geoip2` library).

---

The module defines a `geolocator` plugin type (annotation `@GeoLocator`, manager
`plugin.manager.geolocator`, base `GeoLocatorBase`) and a `geoip.geolocation` service wrapping
the currently-selected plugin. You call `\Drupal::service('geoip.geolocation')->geolocate($ip)`
to get an ISO country code (or NULL); results are cached permanently per IP under cache tag
`geoip`. A settings form at `/admin/config/system/geoip` (`geoip.configure`, gated by the core
`administer site configuration` permission) picks the active plugin and toggles a debug log; the
choice persists in `geoip.geolocation` config (`plugin_id`, `debug`). The **CDN** plugin returns
the value of `HTTP_CF_IPCOUNTRY` (Cloudflare) or `HTTP_CLOUDFRONT_VIEWER_COUNTRY` (CloudFront)
from the request; a "custom header" option is stubbed but not implemented. The **Local** plugin
looks for `GeoLite2-City.mmdb` then `GeoLite2-Country.mmdb` in the public files directory and
returns `country->isoCode` (city DB is supported but still only country is read); it needs the
MaxMind database file placed manually and the `geoip2/geoip2` Composer library. `hook_requirements`
reports whether a database is present and warns if it is over a month old. The module itself only
provides the lookup API — you wire the country code into your own access, redirect, or
personalization logic. **Default shipped plugin is `cdn`.**

---

- Look up the country code for the current visitor's IP address programmatically.
- Geolocate an arbitrary IP address to an ISO country code from custom code.
- Read a Cloudflare-provided country (`CF-IPCountry`) without your own database.
- Read an Amazon CloudFront viewer country header.
- Use a self-hosted MaxMind GeoLite2 country/city database for offline geolocation.
- Choose which geolocation source is active site-wide from an admin form.
- Cache geolocation results per IP to avoid repeated database/header lookups.
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
- Swap between CDN and local geolocation without changing calling code.
- Build a "you appear to be in X" banner with a manual override.
- Supply country data to a multi-site / affiliate routing layer.
