# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Commerce Product** (`commerce_product`) and **Commerce Cart** (`commerce_cart`)
  — the cart/checkout foundation the reservation flow builds on. The module uses
  Commerce Cart's `add_to_cart` order-item form mode.
- **Commerce AJAX Cart Message** (`commerce_ajax_cart_message`).

Drupal will pull in these dependencies when you enable the module. There are no
third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_reservation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_product_reservation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_reservation -y
```

On enable, the module creates a **reservation item** order-item type, a
**reservation** order type, and a **reservation** checkout flow. You will typically
want to edit the checkout flow afterwards to trim it to what a reservation needs.

## Submodules

The project ships an example implementation you can enable to see the flow working:

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Commerce Product Reservation Simple** | `commerce_product_reservation_simple` | A reference store-data provider. It returns a single store (the same as your online store) and always reports the product as available. Enable it to demo the reservation flow end-to-end, or use it as a template for writing your own store/availability plugin. |

```bash
drush en commerce_product_reservation_simple -y
```

## Verify it worked

Check **Commerce → Configuration** for the new **reservation** order type and
**reservation item** order-item type, and **Commerce → Configuration → Checkout
flows** for the **reservation** checkout flow. If you enabled the Simple submodule,
walk through a reservation on the storefront to confirm the flow completes with the
single example store.
