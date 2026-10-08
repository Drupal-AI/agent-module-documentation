# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce 3** with the **Payment** module (`commerce_payment`) enabled —
  this is the module dependency.
- A **Paynow (mBank)** merchant account with an **API Key** and a **Signature Key**.

There are no third‑party Composer libraries you install separately — the Paynow SDK
is pulled in as a Composer dependency of the module.

> **Note:** this project is listed as **not covered** by Drupal's security advisory
> policy. Review the project's issue queue before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_paynow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_paynow -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_paynow -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm that **Paynow** appears in the plugin list. Then follow
[Configuration](../configuration/index.md).
