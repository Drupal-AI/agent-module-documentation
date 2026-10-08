# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Commerce Cart** (`commerce_cart`) and **Commerce Product**
  (`commerce_product`) from Drupal Commerce.
- Core **Views** (`views`) — the confirmation is a view, so this is required.

There are no extra PHP or third‑party library requirements. Note this is the 2.0.x
branch; version 2.0.0 requires Drupal 10.3.0 or newer.

## Install with Composer

The maintainers stress this module should be installed **via Composer** (the zip
files on drupal.org are informational only). From the project root:

```bash
composer require drupal/commerce_add_to_cart_confirmation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_add_to_cart_confirmation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_add_to_cart_confirmation -y
```

That is all the setup required — the confirmation immediately replaces the default
add‑to‑cart message.

## Verify it worked

On your storefront, add a product to the cart. Instead of the small "item added"
status message, you should now see the richer confirmation. To customise it, edit
the **Commerce Add to Cart Confirmation** view under **Structure → Views**
(`/admin/structure/views`).
