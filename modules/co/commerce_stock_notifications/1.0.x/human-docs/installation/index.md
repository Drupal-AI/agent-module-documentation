# Installation

## Requirements

- **Drupal 8.8+, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 7.0 or newer**.
- **Drupal Commerce**, including **Commerce Cart** (`commerce_cart`) and **Commerce
  Product** (`commerce_product`).
- **Commerce Stock** (`commerce_stock`) and its **Stock Field** (`commerce_stock_field`) —
  the module reads availability from Commerce Stock, so your products must be set up with
  stock tracking.
- **Token** (`token`) — used to build the notification message text.

Composer will fetch these dependencies for you.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_stock_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_stock_notifications -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_stock_notifications -y
```

## Verify it worked

Make sure a product is set to out-of-stock in Commerce Stock, then view it on the
storefront. The *Add to cart* area should now offer a field to enter an email address and
request a back-in-stock notification. Then continue to
[Configuration](../configuration/index.md) to tailor the message text and set permissions.
