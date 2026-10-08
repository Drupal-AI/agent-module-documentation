# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with **Commerce Payment** (`commerce_payment`) and
  **Commerce Tax** (`commerce_tax`) installed.
- A **Payson merchant account** with API/agent credentials for Payson Checkout
  2.0. No extra PHP library is needed — the module uses Payson's REST API.

## Install with Composer

Installing with Composer pulls in the Commerce dependencies if they are not
already present:

```bash
composer require drupal/payson_checkout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/payson_checkout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en payson_checkout -y
```

Drupal enables `commerce_payment` and `commerce_tax` automatically as dependencies
if they are not already on.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. A
**Payson Checkout** gateway type should be available. Continue in
[Configuration](../configuration/index.md).
