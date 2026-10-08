# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- A **free GeoNames user account** — the only real requirement. Register at
  [geonames.org/login](https://www.geonames.org/login) and enable your account for
  free web-service (API) access. See
  [geonames.org/export/web-services](https://www.geonames.org/export/web-services)
  for details.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/location_selector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/location_selector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en location_selector -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → Location Selector →
Settings** (`/admin/config/location_selector/settings`). You should see the field
for your GeoNames username. Once that's set (see
[Configuration](../configuration/index.md)), add a **Location Selector** field to a
content type and confirm the hierarchical select lists populate from GeoNames.
