# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Commerce** (`commerce`) and **Commerce Cart** (`commerce_cart`) from the
  [Drupal Commerce](https://www.drupal.org/project/commerce) suite.

There are no additional PHP library requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_repeat_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_repeat_order -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_repeat_order -y
```

## Verify it worked

Review the module's permission at **People → Permissions** and its cart-behaviour
setting (see [Configuration](../configuration/index.md)), then place a
repeat-order link against one of your own past orders and confirm clicking it
rebuilds the cart.
