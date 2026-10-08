# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Drupal **Commerce** with **Commerce Payment** (`commerce_payment`) and **Commerce
  Order** (`commerce_order`) enabled — these are the module dependencies.
- A **Payeezy (First Data) developer account** and API keys (create one at
  developer.payeezy.com).

There are no third‑party Composer libraries required for the Drupal 10/11 setup.
(On legacy Drupal 7 the Payeezy PHP library had to be placed manually — that does
not apply to the modern versions this guide covers.)

> **Note:** this project is listed as **not covered** by Drupal's security advisory
> policy and is in *maintenance fixes only* status. See the operating notes on the
> [overview page](../index.md) before going live.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_payeezy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_payeezy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_payeezy -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the Payeezy plugin(s) appear. Then follow
[Configuration](../configuration/index.md) to enter your API keys and run a test
transaction.
