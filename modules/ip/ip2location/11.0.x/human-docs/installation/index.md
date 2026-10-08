# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`ip2location/ip2location-php`** PHP library, installed with Composer —
  this is what actually reads the BIN database.
- An **IP2Location BIN database file** — the free
  [LITE](https://lite.ip2location.com) edition or a
  [commercial](https://www.ip2location.com) DBn edition. The module ships without
  one.

## Install with Composer

Install the module and the required library:

```bash
composer require drupal/ip2location -W
composer require ip2location/ip2location-php
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ip2location -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ip2location -y
```

## Get a BIN database

1. Download a database file — a free LITE database from
   [lite.ip2location.com](https://lite.ip2location.com) or a commercial one from
   [ip2location.com](https://www.ip2location.com). Richer editions (higher DBn
   numbers) return more fields.
2. Place the file somewhere the web server can read, for example
   `sites/default/files/IP2Location-LITE-DB11.BIN`.
3. Point the module at it on the settings form — see
   [Configuration](../configuration/index.md).

## Verify it worked

On the settings form, after entering the path, saving triggers a built‑in test
lookup of `8.8.8.8` — if the path is valid and the library is installed, the form
saves without complaint. To confirm end to end, call
`ip2location_get_records('8.8.8.8')` from code (or the `8.8.8.8` test on the form)
and check that a populated object is returned.
