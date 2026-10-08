# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with **Commerce Cart**, **Commerce Store**, **Commerce
  Checkout**, and **Commerce Product** enabled. Drupal enables these dependencies
  for you when you turn on the module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_buy_now -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_buy_now -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_buy_now -y
```

## Verify it worked

Visit a product page and use the **Buy Now** button — it should add the product to
the cart and take you directly to the checkout, skipping the cart page. Test with
a product that requires options or a quantity to confirm the behaviour suits your
store before relying on it in production.
