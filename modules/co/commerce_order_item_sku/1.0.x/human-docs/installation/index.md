# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Drupal **Commerce** (`commerce`) and **Commerce Order** (`commerce_order`),
  version **3.0.0 or newer** — these are the module dependencies.

There are no third‑party Composer libraries or special PHP extensions required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_order_item_sku -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_order_item_sku -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_order_item_sku -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Enabling the module alone does not yet store SKUs — you must switch on the trait
per order item type. Follow [Configuration](../configuration/index.md), then place a
test order and confirm the SKU is now recorded on the order item (and still shown
correctly even after you change the product variation's SKU).
