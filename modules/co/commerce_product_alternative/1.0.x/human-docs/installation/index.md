# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Drupal Commerce**, including the **Product** (`commerce_product`), **Order**
  (`commerce_order`), **Cart** (`commerce_cart`), and **Log** (`commerce_log`)
  modules. These are the module's dependencies and Drupal will enable what it
  needs.

There are no additional Composer or PHP library requirements beyond Drupal
Commerce.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_alternative -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_product_alternative -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_alternative -y
```

## Verify it worked

There is no settings page. Instead, go to **Commerce → Configuration → Product
variation types**, edit a type, and confirm an **Alternative Variations** trait is
now available to enable. See [How to use it](../index.md#how-to-use-it) on the
overview page for the full walkthrough, including exposing the swap links in your
cart View.
