# Configuration

GeoIP's configuration is a single choice — which geolocation source is active —
plus the settings that source needs.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → GeoIP** (`/admin/config/system/geoip`).

Your choices are saved in the `geoip.geolocation` config object.

## Choose the active geolocation plugin

Pick one source from the plugin selector. The right choice depends on your hosting:

### CDN (default)

Use this when your site is behind a CDN or reverse proxy that already tells you the
visitor's country. It reads, in order: your **custom header** (if set), then
Cloudflare's `CF-IPCountry`, then CloudFront's viewer-country header.

- **Custom header** — the name of a country header set by another CDN or proxy
  (for example a Fastly or Varnish header). Leave blank to rely on the Cloudflare
  and CloudFront headers only. This is the fastest option and needs no database.

### Local

Use this for fully offline geolocation from a self-hosted MaxMind GeoLite2
database. The plugin looks for `GeoLite2-City.mmdb`, then `GeoLite2-Country.mmdb`,
in your public files directory and returns the ISO country code.

- Make sure the database file is present (place it yourself, or install the
  **GeoLite2 Database Update** submodule to fetch and refresh it — see
  [Installation](../installation/index.md)).
- The **Status report** warns you if the database is missing or stale.

### Webservice

Use this to query MaxMind's hosted GeoIP2 web service instead of shipping a
database. It needs your MaxMind credentials:

- **Account ID** — your MaxMind account ID.
- **License key** — your MaxMind license key. Treat this as a secret; the
  [Installation](../installation/index.md) page shows the DDEV environment-variable
  pattern for keeping it out of version control.

## Other options

- **Debug log** — turn on a debug log channel to trace exactly how each IP was
  resolved. Handy while setting up, but turn it off in production to avoid noise.
- **Manual IP lookup** — an AJAX field on the form that runs the active plugin
  against an IP you type, so you can confirm your setup returns the expected
  country before wiring it into anything.

## Save

Click **Save configuration**. Remember that GeoIP only provides the lookup — the
country code it returns is consumed by other modules or your own code (access
checks, redirects, personalization, the `geoip_country` cache context, and so on).
