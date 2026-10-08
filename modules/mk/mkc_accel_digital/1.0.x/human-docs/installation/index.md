# Installation

## Requirements

- **Drupal 11.3+** (`core_version_requirement: ^11.3 || ^11`) on **PHP 8.2+**.
- **MonkeysCommerce** installed, with the **`mkc_core`**, **`mkc_catalog`** and
  **`mkc_order`** modules enabled — these are hard dependencies.

There are no additional third-party PHP library requirements for this accelerator.

## Install with Composer

From the project root:

```bash
composer require drupal/mkc_accel_digital -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies as needed. (MonkeysCommerce and its required modules must be available
to Composer / already installed.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mkc_accel_digital -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mkc_accel_digital -y
```

This also ensures the required MonkeysCommerce modules are enabled.

## Verify it worked

Log in as an administrator and visit **`/admin/commerce/digital/settings`** — the
digital-goods settings form should load, and the **Downloads** and **Licenses**
management screens should be reachable under **Commerce → Digital**. Then continue
with [Configuration](../configuration/index.md).
