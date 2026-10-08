# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Two geolocation PHP libraries, pulled in automatically by Composer:
  - **geoip2/geoip2** (`~2.0`) — used by the MaxMind data sources.
  - **ip2location/ip2location-php** (`~8.0 || ~9.0`) — used by the IP2Location
    binary-database source.
- A **data source** — Smart IP ships no lookup database of its own. You must
  enable one of its data-source submodules (below) and, for most of them, supply
  either a database file or an API key/credentials. See
  [Configuration](../configuration/index.md).

Because of the library requirements, install with Composer rather than by hand so
the GeoIP2 and IP2Location packages are resolved for you.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_ip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/smart_ip -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en smart_ip -y
```

## Enable a data source submodule

Smart IP does nothing until you enable **one** data source and select it. The
bundled submodules are:

| Submodule | Machine name | What it uses |
|-----------|--------------|--------------|
| **MaxMind GeoIP2 binary database** | `smart_ip_maxmind_geoip2_bin_db` | A downloadable MaxMind GeoIP2 `.mmdb` database stored on your server (offline lookups, auto-updatable). |
| **MaxMind GeoIP2 web service** | `smart_ip_maxmind_geoip2_web_service` | MaxMind's GeoIP2 Precision web service (on-demand lookups; needs MaxMind credentials). |
| **IP2Location binary database** | `smart_ip_ip2location_bin_db` | An IP2Location binary database file on your server. |
| **IPInfoDB web service** | `smart_ip_ipinfodb_web_service` | The IPInfoDB API (needs an API key). |
| **Abstract web service** | `smart_ip_abstract_web_service` | The Abstract IP-geolocation API (needs an API key). |
| **Device Geolocation** | `device_geolocation` | The visitor's browser (W3C Geolocation API) for precise client-side coordinates. |

Enable the one you want, for example the MaxMind binary database:

```bash
drush en smart_ip_maxmind_geoip2_bin_db -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → People → Smart IP**
(`/admin/config/people/smart_ip`). You should see the settings form, and the data
source you enabled should be selectable. Continue to
[Configuration](../configuration/index.md) to select and feed it.
