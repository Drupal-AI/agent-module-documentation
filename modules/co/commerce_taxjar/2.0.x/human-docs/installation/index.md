# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- **Drupal Commerce** with the **Order**, **Store**, **Tax**, and **Payment**
  components enabled (`commerce_order`, `commerce_store`, `commerce_tax`,
  `commerce_payment`).
- A **TaxJar account and API token** — sign up at taxjar.com and copy your API
  token from the account dashboard.
- Outbound HTTPS access from your server to the TaxJar API.

Optional but supported: **Commerce Shipping** and **Commerce Discount**, so tax is
calculated correctly for shipping charges and discounts.

There are no third‑party PHP library requirements beyond Drupal Commerce.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_taxjar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_taxjar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_taxjar -y
```

Commerce's Order, Store, Tax, and Payment components are enabled automatically as
dependencies if they aren't already.

## Verify it worked

Go to **Commerce → Configuration → Tax types**
(`/admin/commerce/config/tax-types`) and click **Add tax type** — a TaxJar option
should be available. Then continue to [Configuration](../configuration/index.md)
to enter your API token and connect the service.
