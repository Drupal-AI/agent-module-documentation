# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Drupal **Commerce** and **Commerce Shipping** (`commerce_shipping`) enabled.
- Your products should carry **weights (in kg)** so the rate can be computed; the
  module treats all weights as kilograms.

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_linear_weight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_shipping_linear_weight -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_linear_weight -y
```

## Verify it worked

Go to **Commerce → Configuration → Shipping methods**
(`/admin/commerce/shipping-methods`), click **Add shipping method**, and confirm
the **Linear Weight Shipping** plugin appears in the list. Then continue to
[Configuration](../configuration/index.md).
