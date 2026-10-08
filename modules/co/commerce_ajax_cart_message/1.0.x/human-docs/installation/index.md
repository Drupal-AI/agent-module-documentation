# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Commerce Cart** (`commerce_cart`) from Drupal Commerce — the only dependency.

There are no extra PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_ajax_cart_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_ajax_cart_message -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_ajax_cart_message -y
```

That's the whole setup — there is nothing to configure.

## Verify it worked

On a storefront that adds to the cart via AJAX, add a product. The default "item
added to your cart" status message should no longer appear for that AJAX add, while
a normal (non‑AJAX) add still shows it as before.
