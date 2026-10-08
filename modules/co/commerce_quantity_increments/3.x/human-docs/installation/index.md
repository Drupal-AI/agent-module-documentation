# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** — a strict dependency on Commerce **Product**
  (`commerce_product`) and a soft dependency on Commerce **Cart**
  (`commerce_cart`).

There are no additional PHP library requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_quantity_increments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_quantity_increments -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_quantity_increments -y
```

## Verify it worked

Edit a product variation and set a quantity increment or minimum, then try to add
a quantity that breaks the rule to the cart — it should be rejected, while a valid
multiple is accepted. See the [overview](../index.md) for the per-variation setup.
