# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Payment** module (`commerce_payment`) enabled —
  this is the core dependency and Drupal will pull in the base `commerce` module
  with it.
- A **Fondy merchant account** with a merchant ID and secret key. You obtain
  these from your Fondy dashboard after registering.

There are no additional PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_fondy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_fondy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_fondy -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway** —
**Fondy** should appear in the list of gateway plugins. Continue to
[Configuration](../configuration/index.md) to enter your Fondy credentials and
switch the gateway between test and live mode.
