# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The contrib **Commerce Shipping** module (`drupal/commerce_shipping`, `^2.5 ||
  ^3`), which is part of Drupal Commerce. This is the framework Commerce USPS
  extends, and Composer pulls it in for you.
- A **USPS developer account** with API credentials (a Consumer key and Consumer
  secret) for the current USPS OAuth API. You obtain these from USPS, not from
  Drupal — see [Configuration](../configuration/index.md).

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_usps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Commerce Shipping
and other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_usps -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_usps -y
```

This enables `commerce_shipping` as well if it is not already on. There are no
submodules.

## Verify it worked

Go to **Commerce → Configuration → Shipping → Shipping methods** and click **Add
shipping method**. In the plugin list you should now see **USPS** and **USPS
International**. Continue to [Configuration](../configuration/index.md) to set one
up.
