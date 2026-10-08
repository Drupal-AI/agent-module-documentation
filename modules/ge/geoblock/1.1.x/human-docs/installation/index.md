# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`; Composer
  requires `^10.3 || ^11`).
- **PHP 8.1 or newer**.
- The **`league/iso3166`** PHP library (`^4.0`), used to validate country codes.
  Composer installs it automatically.
- **A `geoblock_data_source` plugin — which Geoblock does NOT ship.** You must
  install or write a companion module that provides one (a GeoIP/geolocation
  backend), or the module can never determine a country and will block nothing.

Geoblock has no dependencies on other Drupal modules.

## Install with Composer

From the project root:

```bash
composer require drupal/geoblock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `league/iso3166`
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geoblock -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geoblock -y
```

## Provide a data source (required)

Geoblock is inert until a geolocation *data source* is available and selected.
There is no submodule for this — install a contrib/custom module that provides a
`geoblock_data_source` plugin, enable it, then choose it under **Data source** on
the settings form (or set `data_source` in `geoblock.settings`). Building one is a
small amount of PHP — see the agent docs' plugin guide
([`agent/plugins/data-source.md`](../../agent/plugins/data-source.md)) for the
interface and a minimal example.

## Verify it worked

Go to **Configuration → Geoblock** (`/admin/config/geoblock`). If the module is
enabled you'll see the settings form. Once you've selected a data source and set
an allow/block rule, test from an IP in a blocked country (or via a VPN) — a
matching request should return **403 Forbidden**. Then head to
[Configuration](../configuration/index.md) to set your rules.
