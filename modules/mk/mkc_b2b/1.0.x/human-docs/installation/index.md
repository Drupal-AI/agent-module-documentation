# Installation

## Requirements

- **Drupal 11.3+** (`core_version_requirement: ^11.3 || ^11`) on **PHP 8.2+**.
- **MonkeysCommerce** installed, with the following modules enabled — all are hard
  dependencies:
  - `mkc_core`
  - `mkc_catalog`
  - `mkc_cart`
  - `mkc_order`
  - `mkc_checkout`
  - `mkc_payment`
  - `mkc_pricing`

There are no additional third-party PHP library requirements for this module.

## Install with Composer

From the project root:

```bash
composer require drupal/mkc_b2b -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies as needed. (MonkeysCommerce and its required modules must be available
to Composer / already installed.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mkc_b2b -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mkc_b2b -y
```

This also ensures the required MonkeysCommerce modules are enabled.

## Verify it worked

Log in as an administrator and visit **`/admin/commerce/b2b`** — the B2B dashboard
should load, and **`/admin/commerce/b2b/settings`** should open the configuration
form. Then continue with [Configuration](../configuration/index.md) — and if you
plan to use PunchOut, set the shared secret before going live.
