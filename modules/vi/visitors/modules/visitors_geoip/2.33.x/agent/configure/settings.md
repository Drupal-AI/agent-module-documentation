<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Settings form: `/admin/config/system/visitors/geoip` (route `visitors_geoip.settings`,
permission `administer site configuration`). Values are stored in the config object
**`visitors_geoip.settings`**.

## Config keys (`visitors_geoip.settings`)

| Key | Default | Meaning |
|---|---|---|
| `geoip_path` | `../` | Filesystem location of the MaxMind GeoLite2 database (`.mmdb`). |
| `license` | `''` | MaxMind license key (used by the download command). Store secrets out of VCS. |

```bash
drush config:get visitors_geoip.settings
drush config:set visitors_geoip.settings geoip_path '/var/lib/geoip/' -y
```

## Getting the database

1. Set your MaxMind `license` key (or provide the `.mmdb` file manually and point `geoip_path`
   at it).
2. Download/update the GeoLite2 City database: `drush visitors:download:city`.
3. Populate geo data for already-logged hits: `drush visitors:rebuild:location` (or the form at
   `/admin/config/system/visitors/rebuild-location`).

## Reports

New location reports appear under the Visitors reports (permission `access visitors`):

- `/visitors/location/region/{country}/{region}`
- `/visitors/location/city/{country}/{region}/{city}`

plus the provided `views.view.visitors_geoip` view.

## Service

`visitors_geoip.lookup` (`Drupal\visitors_geoip\Service\GeoIpService`): `city($ip)` resolves an
IP; `metadata()` returns the DB metadata; `hasLibrary()` / `hasExtension()` report whether the
`GeoIp2\Database\Reader` library and `maxminddb` extension are available.
