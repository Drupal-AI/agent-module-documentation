# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`). For Drupal 9,
  use the 2.0 release instead (see below).
- **Drupal Commerce** (`commerce`) and **Commerce Price** (`commerce_price`)
  enabled — these are the module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_currencies_price -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **On Drupal 9?** Pin the last compatible release explicitly:
> `composer require 'drupal/commerce_currencies_price:2.0'`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_currencies_price -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_currencies_price -y
```

## Verify it worked

Go to a **Manage fields** screen (for example a product variation type) and add a
field. **Commerce Currencies Price** should appear as an available field type. See
"How to use it" in the [overview](../index.md) for filling in per‑currency prices.
