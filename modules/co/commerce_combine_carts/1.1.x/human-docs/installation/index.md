# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Drupal Commerce** with its **Cart** submodule (`commerce_cart`) enabled — Drupal
  enables it automatically as a dependency. This is a Drupal Commerce 2.x module.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_combine_carts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_combine_carts -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_combine_carts -y
```

## Next step

That's it — there is nothing to configure. From now on each customer is kept to a
single active cart per order type automatically. See
[How to use it](../index.md#how-to-use-it).
