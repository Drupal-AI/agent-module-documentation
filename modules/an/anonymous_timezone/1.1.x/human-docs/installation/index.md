# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- **PHP 8.0 or newer**.
- The **`geoip2/geoip2`** PHP library (version `~2.0`), installed via Composer.
- A **MaxMind GeoIP2 or GeoLite2** database file (a city or country database) that
  the module can read. You download this from MaxMind and place it on your server.

## Install with Composer

From the project root, require the module — pull in the GeoIP2 library at the same
time:

```bash
composer require drupal/anonymous_timezone geoip2/geoip2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Make sure the `geoip2/geoip2` library is present **before**
you enable the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/anonymous_timezone geoip2/geoip2 -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en anonymous_timezone -y
```

After enabling, you must point the module at your GeoIP database file before it can
resolve timezones — see [Configuration](../configuration/index.md).
