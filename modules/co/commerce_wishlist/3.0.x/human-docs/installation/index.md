# Installation

## Requirements

Commerce Wishlist is an add-on for Drupal Commerce, so it needs a working
Commerce install. Specifically:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Drupal Commerce** `^2.15 || ^3` (`drupal/commerce`), plus its **Cart**
  (`commerce_cart`) and **Store** (`commerce_store`) modules.
- **Inline Entity Form** (`drupal/inline_entity_form`, `~1.0 || ^3`).
- **Profile** (`drupal/profile`, `~1.0`).

Composer pulls these in automatically when you require the module, and Drupal
enables the dependent modules for you when you turn Wishlist on.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_wishlist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the shared
Commerce dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_wishlist -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_wishlist -y
```

This also enables Commerce Cart, Store, Inline Entity Form and Profile if they
are not already on. There are no submodules — everything ships in the one
module.

## Verify it worked

Visit a product page as a logged-in customer: you should see an **"Add to
wishlist"** control near the add-to-cart form (you may first need to enable the
button on the add-to-cart display — see
[Configuration](../configuration/index.md)). Every customer now has a wishlist
page at `/wishlist`.
