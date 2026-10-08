# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** — the module extends the Commerce add-to-cart and order flow.
  (This release is a beta; try it on a non-production copy first.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_quantity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_product_quantity -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_quantity -y
```

## Verify it worked

Go to **Commerce → Configuration → Product**. You should see the module's
**Product Quantity** and **Product Type Quantity** settings pages. Set a small
limit on a test product, then try to add more than that many to the cart on the
storefront — the order should be held to your limit. See
[Configuration](../configuration/index.md) for the details of each form.
