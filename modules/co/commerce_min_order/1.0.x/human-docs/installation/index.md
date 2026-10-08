# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with its **Cart** (`commerce_cart`) and **Order**
  (`commerce_order`) modules — all part of Commerce.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_min_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_min_order -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_min_order -y
```

## Set the minimum (required)

The module does nothing until you add a **Number** field with the machine name
**`field_store_min_order`** to your Store type and give it a value on each store.
See "How to set the minimum" in the [overview](../index.md) for the steps.

## Verify it worked

With the store field set to a non-zero minimum, add a cheap item to the cart and
open the cart page. You should see the progress meter, and the checkout button
should stay disabled until the cart total reaches the minimum. Add enough to cross
the threshold and confirm checkout becomes available.
