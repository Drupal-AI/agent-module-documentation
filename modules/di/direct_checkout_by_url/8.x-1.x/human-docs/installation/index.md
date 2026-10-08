# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Drupal Commerce** with its Product, Order, Cart, and Checkout modules enabled
  (`commerce_product`, `commerce_order`, `commerce_cart`, `commerce_checkout`).
  This module has no reason to exist without Commerce, so set that up first.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/direct_checkout_by_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/direct_checkout_by_url -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en direct_checkout_by_url -y
```

If the required Commerce modules are present, Drupal enables them as dependencies.

## Verify it worked

1. Grant the permissions described in [Configuration](../configuration/index.md) to
   the roles that should use the feature.
2. Take the SKU of a product that can be purchased and visit
   `/direct-checkout-by-url?products=<SKU>` on your site. You should be taken to the
   checkout page with that product already in the cart. Add `&destination=cart` to
   land on the cart page instead.
