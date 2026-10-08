# Configure GeoIP

Settings form: `/admin/config/system/geoip` (route `geoip.configure`, class
`GeolocationSettings`), gated by the **core** permission `administer site configuration`
(the base module ships no permissions.yml). Menu link under *Configuration → System*.
The form has a plugin picker (`tableselect`), a Webservice details section (shown when
`webservice` is selected), a CDN details section (custom header, shown when `cdn` is selected),
a debug toggle, and an AJAX **Manual lookup** that runs the active plugin against an entered IP.

## Config object `geoip.geolocation`

| Key | Type | Default (config/install) | Meaning |
|---|---|---|---|
| `plugin_id` | string | `cdn` | Machine id of the active GeoLocator plugin (`cdn`, `local`, `webservice`, or a custom one). |
| `debug` | bool | `false` | When on, the active plugin logs how each IP was resolved to the `geoip` log channel. |
| `account_id` | string | `''` | MaxMind account ID for the `webservice` plugin. |
| `license_key` | string | `''` | MaxMind license key for the `webservice` plugin. |
| `custom_header` | string | `''` | HTTP header name the `cdn` plugin reads first (e.g. `Fastly-Client-Country`). Added by `geoip_update_10001()` on existing sites. |

Schema: `geoip.geolocation` (`config/schema/geoip.schema.yml`).

Set via Drush:
```bash
drush config:set geoip.geolocation plugin_id local -y
drush config:set geoip.geolocation custom_header 'Fastly-Client-Country' -y
drush config:set geoip.geolocation debug 1 -y
```

## The three shipped plugins

| Plugin id | Label | Weight | Source of truth |
|---|---|---|---|
| `cdn` (**default**) | CDN | -10 | Request headers, checked in order: configured `custom_header` → `HTTP_CF_IPCOUNTRY` (Cloudflare) → `HTTP_CLOUDFRONT_VIEWER_COUNTRY` (CloudFront). `custom_header` is checked **first** and can override a present-but-wrong built-in header. `Cdn::headerToServerKey()` maps a header name like `Fastly-Client-Country` to `$_SERVER['HTTP_FASTLY_CLIENT_COUNTRY']`. |
| `local` | Local dataset | 0 | MaxMind GeoLite2 `.mmdb` in `public://` (City first, then Country), read with `geoip2/geoip2`. Only `country->isoCode` is read. |
| `webservice` | Webservice | 10 | MaxMind hosted GeoIP2 web service (`GeoIp2\WebService\Client`) using `account_id` + `license_key`. Returns NULL if either credential is empty. |

## Installing the Local (MaxMind) database

1. `composer require geoip2/geoip2:^3` (required for the Local plugin; enforced at install by
   `hook_requirements`).
2. Get a GeoLite2 **Country** or **City** `.mmdb`, either manually from MaxMind or automatically
   via the **geolite2_update** submodule (see [geolite2-update.md](geolite2-update.md)).
3. Place it in the public files dir as `sites/default/files/GeoLite2-Country.mmdb` (or
   `GeoLite2-City.mmdb`). The Local plugin checks City first, then Country; either way it only
   reads `country->isoCode`.
4. Set `plugin_id` to `local`.

`hook_requirements` (status report) reports which database will be used, warns if none is found,
and warns "Out of date!" when the `.mmdb` file's mtime is older than one month.

> The Local plugin's file scheme is the `$scheme` property (default `public`), exposed via
> `getScheme()`. To serve the DB from `private://`, subclass `Local` and override `getScheme()`
> (see [../plugins/geolocator.md](../plugins/geolocator.md)).

> Note: `Local` defines `GEOLITE_CITY_DB` / `GEOLITE_COUNTRY_DB` `http://` URL constants, but they
> are dead code — the Local plugin never downloads; it only reads local files. The actual download
> is done by the geolite2_update submodule over HTTPS.
