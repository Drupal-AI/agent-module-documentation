# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with its **Commerce Order** (`commerce_order`) and **Commerce
  Product** (`commerce_product`) submodules — the fees are applied through Commerce's
  order processing.

There are no third‑party Composer or PHP library requirements. Note this project is
**seeking a co-maintainer** and is in maintenance-fixes-only mode; it is covered by
Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_product_type_fees -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_product_type_fees -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_product_type_fees -y
```

## Verify it worked

Open the fee configuration form under **Commerce → Configuration** (see
[Configuration](../configuration/index.md)), add a percentage fee to a product type,
then add a product of that type to the cart. The fee should appear on the order and
be reflected in the total.
