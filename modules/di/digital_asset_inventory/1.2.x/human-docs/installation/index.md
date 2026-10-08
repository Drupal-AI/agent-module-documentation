# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer**.
- Drupal core's **File**, **Media**, and **Views** modules (part of a standard
  install).
- Three contributed modules, pulled in by Composer:
  - **Better Exposed Filters** (`drupal/better_exposed_filters ^6 || ^7`) — for the
    report filters.
  - **Views Data Export** (`drupal/views_data_export ^1.9`) — for CSV export.
  - **CSV Serialization** (`drupal/csv_serialization ^4`) — the CSV encoder.

## Install with Composer

From the project root:

```bash
composer require drupal/digital_asset_inventory -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Better Exposed Filters, Views Data Export, and CSV Serialization dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/digital_asset_inventory -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en digital_asset_inventory -y
```

This enables the contributed dependencies too. Then apply any pending database
updates, which the scanner requires:

```bash
drush updb -y
```

If you run a scan before applying updates, it will stop with a "Database updates
are pending" message — running `drush updb` clears it.

## Next steps

Once enabled, grant permissions and review the scanner and archive settings — see
[Configuration](../configuration/index.md) — then run your first scan from the Scan
form or with `drush dai:scan`.
