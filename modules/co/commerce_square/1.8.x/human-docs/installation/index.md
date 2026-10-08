# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **PHP 7.3 or 8.x** (`php: ^7.3 || ^8.0`).
- **Drupal Commerce** version 2.39+ or 3 (`drupal/commerce: ~2.39 || ^3`), with
  the **Commerce** and **Commerce Payment** modules enabled — these are the
  declared dependencies.
- The **`square/square`** PHP SDK (version 34.x). This is a hard Composer
  requirement and is installed automatically when you require the module.
- A **Square account** and access to Square's developer dashboard, where you
  create an application to obtain the credentials the settings form needs.
- Network access from your site to Square's API for real (sandbox or live)
  transactions.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_square -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in Drupal Commerce (if not already present)
and the required `square/square` SDK.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_square -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_square -y
```

Grant the administration permission to whoever will configure Square:

```bash
drush role:perm:add administrator 'administer commerce square'
```

There are **no submodules**. Next, enter your Square credentials and add the
gateway — see [Configuration](../configuration/index.md).
