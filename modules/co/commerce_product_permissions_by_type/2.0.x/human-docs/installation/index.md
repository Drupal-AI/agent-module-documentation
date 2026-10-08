# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Commerce Cart** (`commerce_cart`) — the module integrates with the cart's
  add-to-cart form, and Drupal enables Commerce's dependencies with it.

There are no third‑party Composer or PHP library requirements. Note that this
project is **minimally maintained** and **not covered** by Drupal's security
advisory policy, so review its behaviour against your own access needs before using
it to gate sensitive catalogues.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_permissions_by_type -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_product_permissions_by_type -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_permissions_by_type -y
```

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`). For every Commerce
product type you should now see two new permissions — "{Product type}: View
products" and "{Product type}: Add products to cart". Grant them to a test role,
then browse the storefront as that role (and as anonymous) to confirm the
view/add‑to‑cart behaviour matches your intent. Remember to remove Commerce core's
blanket product-view grant if you want the view permission to be genuinely
restrictive.
