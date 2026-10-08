# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- **PHP** as required by your Drupal and Commerce versions.
- **Drupal Commerce 2.29+ or 3.x** (`drupal/commerce: ^2.29 || ^3.0`). The module
  specifically needs the **Cart** (`commerce_cart`) and **Product**
  (`commerce_product`) submodules, which Drupal enables as dependencies.

Composer will pull in Commerce for you if it isn't already present.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_add_to_cart_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Commerce) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_add_to_cart_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_add_to_cart_link -y
```

The "Add to cart link" field is now available (but hidden) on your product and
variation displays — see [Configuration](../configuration/index.md) to turn it on.

## Optional submodule — wishlist links

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Commerce add to wishlist link** | `commerce_add_to_wishlist_link` | Mirrors everything this module does, but for **Commerce Wishlist** — a one-click "Add to wishlist" link for listings and views. Requires the [Commerce Wishlist](https://www.drupal.org/project/commerce_wishlist) module. |

Enable it only if you use wishlists:

```bash
drush en commerce_add_to_wishlist_link -y
```
