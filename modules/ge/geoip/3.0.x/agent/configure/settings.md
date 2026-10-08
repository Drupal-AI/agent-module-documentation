# Configure GeoIP

Settings form: `/admin/config/system/geoip` (route `geoip.configure`, class
`GeolocationSettings`), gated by the **core** permission `administer site configuration`
(the module ships no permissions.yml). Menu link under *Configuration → System*.

## Config object `geoip.geolocation`

| Key | Type | Default (config/install) | Meaning |
|---|---|---|---|
| `plugin_id` | string | `cdn` | Machine id of the active GeoLocator plugin (`cdn` or `local`, or a custom one). |
| `debug` | bool | `false` | When on, the active plugin logs how each IP was resolved to the `geoip` log channel. |

Schema: `geoip.geolocation` (`config/schema/geoip.schema.yml`). The form renders one radio
row per discovered plugin (label + description from the annotation) and a Yes/No debug toggle.

Set via Drush:
```bash
drush config:set geoip.geolocation plugin_id local -y
drush config:set geoip.geolocation debug 1 -y
```

## The two shipped plugins

| Plugin id | Label | Source of truth |
|---|---|---|
| `cdn` (**default**, weight -10) | CDN | Request headers `HTTP_CF_IPCOUNTRY` (Cloudflare) → `HTTP_CLOUDFRONT_VIEWER_COUNTRY` (CloudFront). A custom-header option is stubbed (`checkCustomHeader()` returns NULL — not implemented). |
| `local` (weight 0) | Local dataset | MaxMind GeoLite2 `.mmdb` in `public://`, read with `geoip2/geoip2`. |

## Installing the Local (MaxMind) database

1. `composer require geoip2/geoip2:~2.0` (required for the Local plugin; enforced at install by
   `hook_requirements`).
2. Download a GeoLite2 **Country** or **City** database from MaxMind, extract the `.mmdb`.
3. Place it in the public files dir as `sites/default/files/GeoLite2-Country.mmdb` (or
   `GeoLite2-City.mmdb`). The Local plugin checks City first, then Country; either way it only
   reads `country->isoCode`.
4. Set `plugin_id` to `local`.

`hook_requirements` (status report) reports which database will be used, warns if none is found,
and warns "Out of date!" when the `.mmdb` file's mtime is older than one month.

> The Local plugin's file scheme is hardcoded to `public`. To serve the DB from `private://`,
> subclass `Local` and override `getScheme()` (see [../plugins/geolocator.md](../plugins/geolocator.md)).
