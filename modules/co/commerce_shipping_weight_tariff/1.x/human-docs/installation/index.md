# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement:
  ^8 || ^9 || ^10 || ^11`).
- **Commerce Shipping 2.x** (`commerce_shipping`), plus **Commerce**
  (`commerce`), **Commerce Order** (`commerce_order`), and **Commerce Price**
  (`commerce_price`).
- **Physical** (`physical`) — the physical fields module, used for product
  weights. This is what supplies the weight data the tariff reads.

All of these are installed automatically as Composer dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_weight_tariff -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Commerce
Shipping, the Physical module, and the other dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/commerce_shipping_weight_tariff -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_weight_tariff -y
```

## Verify it worked

Under **Commerce → Configuration → Shipping methods → Add shipping method**, you
should be able to choose the weight‑tariff shipping method. Before it produces
correct rates you must create your tariff bands (as product entities) and confirm
your products carry accurate weights — see the "How to use it" section of the
[overview](../index.md).
