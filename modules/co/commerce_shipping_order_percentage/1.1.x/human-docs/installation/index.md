# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Drupal **Commerce** with the **Order** (`commerce_order`) and **Price**
  (`commerce_price`) modules, plus **Commerce Shipping** (`commerce_shipping`)
  enabled.

There are no additional Composer library or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipping_order_percentage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_shipping_order_percentage -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipping_order_percentage -y
```

## Verify it worked

Go to **Commerce → Configuration → Shipping methods**
(`/admin/commerce/shipping-methods`), click **Add shipping method**, and confirm
the **Percentage of Order value** plugin appears. Then continue to
[Configuration](../configuration/index.md).
