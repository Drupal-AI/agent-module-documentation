# Installation

## Requirements

Commerce Product Add On needs:

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`). The current release is
  `8.x-1.4`.
- **Drupal Commerce** with its **Cart** (`commerce_cart`) and **Product**
  (`commerce_product`) modules enabled.

There are no additional third-party Composer or PHP library requirements beyond
Commerce itself.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_pado -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Commerce is not yet in your project, add it first:

```bash
composer require drupal/commerce drupal/commerce_pado -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_pado -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_pado -y
```

Commerce Cart and Commerce Product must be enabled (Drush will enable them as
dependencies if they are installed). There is no settings page — configure add-ons
on a product type's view display, as described in
[Configuration](../configuration/index.md).
