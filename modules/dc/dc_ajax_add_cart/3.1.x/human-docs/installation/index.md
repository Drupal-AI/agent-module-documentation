# Installation

## Requirements

Commerce AJAX Add to Cart is an add-on for Drupal Commerce. It needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Drupal Commerce** (`drupal/commerce ^2.4 || ^3`), with its **Commerce Product**
  (`commerce_product`) and **Commerce Cart** (`commerce_cart`) modules enabled.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dc_ajax_add_cart -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update Commerce and its
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dc_ajax_add_cart -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dc_ajax_add_cart -y
```

Enabling the module doesn't change anything on its own — you activate the AJAX behavior by
switching a product type's Variations field to the AJAX formatter, as described in the
[overview](../index.md#how-to-use-it).

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AJAX Add to Cart Popup** | `dc_ajax_add_cart_popup` | A modal "added to cart" confirmation dialog after a product is added. |
| **AJAX Add to Cart Views** | `dc_ajax_add_cart_views` | Views fields that let customers remove a line item and update line-item quantities in the cart form over AJAX. |

Enable them individually, for example:

```bash
drush en dc_ajax_add_cart_popup -y
```

Each submodule requires the base module, which is already present once you have installed it
above.
