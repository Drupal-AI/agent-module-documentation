# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Cart** module enabled
  (`commerce_cart`). Drupal enables this dependency for you when you turn on the
  module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cart_dialog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_cart_dialog -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cart_dialog -y
```

## Verify it worked

Visit `/cart/dialog` on your site — it should render the standard cart contents.
Then go to [Configuration](../configuration/index.md) to choose the dialog type
and place the cart trigger block so shoppers can open the cart in a popup from
anywhere.
