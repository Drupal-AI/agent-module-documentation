# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Commerce's **Payment** module (`commerce_payment`) enabled — the only module
  dependency.
- A **Paymob merchant account** with your **public key**, **secret key**, **API
  key**, one or more **payment integration IDs**, and your **HMAC secret**, for the
  region you operate in (Egypt, Oman, Saudi Arabia, or UAE).

There are no third‑party Composer libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_paymob -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_paymob -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_paymob -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm that **Paymob Redirect** and **Paymob Pixel** appear in the plugin list. Then
follow [Configuration](../configuration/index.md).
