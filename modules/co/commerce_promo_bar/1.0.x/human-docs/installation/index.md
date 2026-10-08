# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Commerce Promotion** (`commerce_promotion`) — so a bar can be linked to a
  Commerce promotion and its coupon tokens.
- Core **Options** (`options`).
- **Color Field** (`color_field`) — provides the background/text colour pickers.

Drupal will pull in these dependencies when you enable the module. There are no
third‑party Composer or PHP library requirements (the countdown timer uses a library
bundled with the module).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_promo_bar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_promo_bar -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_promo_bar -y
```

This also enables Commerce Promotion, Options, and Color Field if they are not
already on.

## Verify it worked

Go to **Commerce → Promo bars** (`/admin/commerce/promo-bars`) and confirm you can
add a promo bar. Then place the **Promo bar block** in a region through **Block
layout** and reload the storefront — a bar that matches the current store, roles,
date, and path should appear. See [Configuration](../configuration/index.md) for the
full walkthrough.
