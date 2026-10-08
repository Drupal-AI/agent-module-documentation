# Installation

## Requirements

- **Drupal 8.9, 9.3, 10 or 11** (`core_version_requirement: ^8.9 || ^9.3 || ^10 || ^11`).
- **Drupal Commerce** (`drupal/commerce` ^2.16 || ^3), with its **Commerce Tax**
  submodule (`commerce_tax`) enabled — this is the dependency the module builds on.
- At least one **Local** tax type configured in Commerce (a tax type whose plugin
  is a local type, such as European Union VAT or a custom local tax type). The Tax
  rate field draws its rates from a local tax type; only local types are offered.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_tax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Commerce and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_product_tax -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_tax -y
```

This enables Commerce Product Tax and, if it isn't already on, Commerce Tax.

## Next step

Enabling the module adds a new **Tax rate** field type but changes nothing on its
own. Attach that field to a product variation type and choose its tax type and
zones — see [Configuration](../configuration/index.md).
