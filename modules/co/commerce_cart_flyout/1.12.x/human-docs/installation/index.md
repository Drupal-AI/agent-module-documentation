# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** (`drupal/commerce` `^2.0 || ^3.0`) — the module uses several
  of its components:
  - **Commerce Cart** (`commerce_cart`)
  - **Commerce Product** (`commerce_product`)
- **Commerce Cart API** (`drupal/commerce_cart_api` `^1.0`) — provides the REST
  endpoints the flyout and add-to-cart JavaScript talk to. Its `commerce_cart_api`
  module must be enabled.

Composer installs Commerce and Commerce Cart API for you; enabling the module turns
on the required submodules automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cart_flyout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Commerce
dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_cart_flyout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cart_flyout -y
```

This enables the required Commerce Cart, Commerce Product, and Commerce Cart API
modules at the same time.

## What happens on install

- Any existing Commerce cart block is automatically switched to render as the
  flyout, so a store that already shows a cart block gets the new experience
  immediately.
- On a module **update**, product displays already using the standard Commerce
  "Add to cart" formatter are migrated to the flyout formatter automatically.

Continue to [Configuration](../configuration/index.md) to place the block (if you
do not already have a cart block), set its one option, and apply the Add to Cart
formatter.
