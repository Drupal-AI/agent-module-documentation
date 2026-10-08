# Installation

## Requirements

- **Drupal core `^9.4 || ^10 || ^11`**.
- **Drupal Commerce** — specifically `commerce`, `commerce_order` and
  `commerce_product`. The module counts sales from completed Commerce orders, so
  Commerce must be installed and in use.

There are no other dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/best_selling_products -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Commerce
dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/best_selling_products -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en best_selling_products -y
```

There is no separate settings page — the module works entirely through its two
blocks. Place and configure them next: see
[Configuration](../configuration/index.md).
