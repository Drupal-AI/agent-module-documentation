# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** with its **Cart** (`commerce_cart`), **Product**
  (`commerce_product`) and **Price** (`commerce_price`) modules enabled.

There are no additional third-party Composer or PHP library requirements beyond
Commerce itself.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_vado -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Commerce is not yet in your project, add it first:

```bash
composer require drupal/commerce drupal/commerce_vado -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_vado -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_vado -y
```

Commerce Cart, Product and Price must be enabled (Drush will enable them as
dependencies if they are installed). Enabling the module registers the
`vado_discount` adjustment type and the module's two permissions.

## Upgrading from an earlier version

If you are upgrading from a 2.x release, run the database updates afterwards so the
module's post-update steps apply:

```bash
drush updatedb -y
drush cr
```

There is no central settings page — configure add-on groups and permissions as
described in [Configuration](../configuration/index.md).
