# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- These modules enabled (Composer pulls them in for you):
  - **[Address](https://www.drupal.org/project/address)** (`address`)
  - **[Geofield](https://www.drupal.org/project/geofield)** (`geofield`)
  - **[Geocoder](https://www.drupal.org/project/geocoder)** — specifically its
    `geocoder_geofield` and `geocoder_address` submodules.
- At least one **geocoder provider** configured (for example Nominatim or Google),
  which is where any provider API key lives.

## Install with Composer

From the project root:

```bash
composer require drupal/address_js_geocoder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update the
Address, Geofield, and Geocoder modules and any other shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_js_geocoder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_js_geocoder -y
```

There is no settings form and no submodules. After enabling, set up the **Address
geocoder** widget on a content type's form display and configure a geocoder
provider on your geofield — see the "How to use it" section of the
[overview](../index.md).
