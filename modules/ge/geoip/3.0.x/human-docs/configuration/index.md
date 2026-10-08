# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → GeoIP** (`/admin/config/system/geoip`).

The form lists one radio option per available GeoLocator plugin (with its label and
description) plus a debug toggle.

## The settings

| Setting | Default | What it does |
|---------|---------|--------------|
| **Plugin** (`plugin_id`) | `cdn` | Which GeoLocator resolves the country: **CDN**, **Local dataset**, or any custom plugin you add. |
| **Debug** (`debug`) | Off | When on, the active plugin logs how each IP was resolved to the `geoip` log channel — useful for troubleshooting. |

You can also set these with Drush:

```bash
drush config:set geoip.geolocation plugin_id local -y
drush config:set geoip.geolocation debug 1 -y
```

## The two shipped plugins

### CDN (default)

Reads the visitor's country from a CDN-set request header — Cloudflare's
`CF-IPCountry`, then CloudFront's `CloudFront-Viewer-Country`. No database needed.

> Use CDN when your site is served through that CDN. A "custom header" option
> exists in the UI but is not implemented.

### Local dataset (MaxMind)

Derives the country from the resolved IP using a local MaxMind GeoLite2 database. To
use it:

1. Make sure the `geoip2/geoip2` library is installed (it is a Composer requirement
   of the module).
2. Download a **GeoLite2 Country** (or City) database from MaxMind and extract the
   `.mmdb` file.
3. Place it in the public files directory as
   `sites/default/files/GeoLite2-Country.mmdb` (or `GeoLite2-City.mmdb`). The plugin
   checks for the City database first, then Country; either way it only reads the
   country code.
4. On the settings form, set **Plugin** to **Local dataset**.

## Checking the status

Go to **Reports → Status report**. GeoIP reports which database will be used, warns
if none is found, and flags the database as **"Out of date!"** when the `.mmdb`
file is more than a month old. Keep it fresh by re-downloading periodically.

## Using the result in code

GeoIP only provides the lookup. From custom code, call the service:

```php
$country = \Drupal::service('geoip.geolocation')->geolocate($ip); // 'US', 'DE', … or NULL
```

Results are cached permanently per IP under the cache tag `geoip`; if you swap the
database or plugin, invalidate that tag to force fresh lookups. For injecting the
service, writing a custom GeoLocator plugin, or reading the country from an event
subscriber, see the [`agent/`](../agent/start.md) docs.
