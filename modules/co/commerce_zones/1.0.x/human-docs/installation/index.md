# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Address** module (`address`) and **Drupal Commerce** (`commerce`) —
  enabled automatically as dependencies. The zone‑building UI is built on
  Address's `address_zone` widget.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_zones -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_zones -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_zones -y
```

## Submodules

Enable these individually only if you need them:

- **Commerce Zones Shipping** (`commerce_zones_shipping`) — integrates zones with
  Commerce Shipping so you can drive shipping availability/logic by zone.

  ```bash
  drush en commerce_zones_shipping -y
  ```

- **Commerce Zones Example** (`commerce_zones_example`) — example configuration
  demonstrating how zones are set up. Handy for learning; you generally would not
  enable it on production.

  ```bash
  drush en commerce_zones_example -y
  ```

## Verify it worked

After enabling, you should be able to create zone entities within the Commerce
configuration area and add the Commerce Zones **condition** to features such as
shipping methods. Review the permissions the module provides under **People →
Permissions** and grant them to the appropriate roles.
