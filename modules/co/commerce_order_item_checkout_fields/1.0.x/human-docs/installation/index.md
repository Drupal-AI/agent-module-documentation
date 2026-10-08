# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Field** module (`field`).
- Drupal Commerce with **Checkout** (`commerce_checkout`), **Order**
  (`commerce_order`), and **Cart** (`commerce_cart`) enabled — these are the module
  dependencies.

There are no third‑party Composer libraries or special PHP extensions required.

> **Note:** This project is listed as **not covered** by Drupal's security
> advisory policy. Review the project's issue queue before using it on a production
> store.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_order_item_checkout_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_order_item_checkout_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_order_item_checkout_fields -y
```

You can also enable it from **Extend** (`/admin/modules`).

> The module's machine name is `commerce_order_item_checkout_fields` even though its
> human-readable name is "Commerce Order Item Fields" — use the machine name in
> Composer and Drush commands.

## Verify it worked

Add at least one field to an order item type (see the
[overview](../index.md#how-to-use-it)), then open your checkout flow at
`/admin/commerce/config/checkout-flows`. A pane whose label ends with "… fields"
should now be available to place on a checkout step. Enable it, then run a test
checkout with a quantity of two or more and confirm you get one set of widgets per
unit, with the values saved onto the order items.
