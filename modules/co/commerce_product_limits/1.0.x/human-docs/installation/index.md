# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Drupal Commerce**, specifically the **Commerce Cart** (`commerce_cart`) and
  **Commerce Product** (`commerce_product`) modules, which Drupal enables as
  dependencies. In other words, you need a working Commerce store.
- No extra Composer libraries or PHP-version requirements.

> **Not compatible with Commerce Cart Flyout.** If your store uses the Cart Flyout
> module, the client-side quantity limits on the cart form will not work with it.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_limits -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_product_limits -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_limits -y
```

There are no submodules and no settings form. Once enabled, head to
[Configuration](../configuration/index.md) to switch on the limit traits for the
product variation types you want to restrict.
