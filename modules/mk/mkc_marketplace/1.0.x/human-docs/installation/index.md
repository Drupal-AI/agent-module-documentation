# Installation

## Requirements

- **Drupal 11.3+** (`core_version_requirement: ^11.3 || ^11`) on **PHP 8.2+**.
- **MonkeysCommerce** installed, with **`mkc_core`**, **`mkc_catalog`**,
  **`mkc_order`**, **`mkc_payment`** and **`mkc_shipping`** enabled — all hard
  dependencies.
- The **`stripe/stripe-php`** PHP library — installed automatically via Composer.
- A **Stripe** account with **Stripe Connect** enabled, for vendor payouts.

## Install with Composer

From the project root:

```bash
composer require drupal/mkc_marketplace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies, including `stripe/stripe-php`. (MonkeysCommerce and its required
modules must be available to Composer / already installed.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mkc_marketplace -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mkc_marketplace -y
```

This also ensures the required MonkeysCommerce modules are enabled.

## Verify it worked

Log in as an administrator and visit **`/admin/commerce/marketplace`** — the
marketplace dashboard should load, and **`/admin/commerce/marketplace/settings`**
should open the configuration form. Then continue with
[Configuration](../configuration/index.md) to set commissions and connect Stripe.
