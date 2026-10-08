# Installation

## Requirements

Commerce Variation Cart Form needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Drupal Commerce** version `^2.16 || ^3`, with its **Product**
  (`commerce_product`), **Order** (`commerce_order`) and **Cart** (`commerce_cart`)
  submodules enabled. Drupal enables these as dependencies when you turn on the
  module.

There are no additional third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_variation_cart_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Commerce (if it is
not already present) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_variation_cart_form -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_variation_cart_form -y
```

Enabling it also turns on the required Commerce submodules if they are not already
active. The module ships an optional **Variation Cart Form** order-item form mode
(showing just the Quantity field) that becomes available once it is enabled.

After enabling, follow [How to use it](../index.md#how-to-use-it) in the overview to
make the per-variation add-to-cart form appear.
