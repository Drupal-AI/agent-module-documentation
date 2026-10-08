# Installation

## Requirements

- **Drupal 8.8.3, 9, or 10** (`core_version_requirement: ^8.8.3 || ^9 || ^10`).
- **PHP 7.1 or newer** (`php_requirement: >=7.1`).
- **Commerce Shipping** (`commerce_shipping`) enabled — the module dependency,
  which pulls in Drupal Commerce.
- The **Physical** module, which provides the dimension and weight field types you
  add to shippable products (installed alongside Commerce Shipping).
- A **Nova Poshta account and API key**.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_novaposhta -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_novaposhta -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_novaposhta -y
```

Commerce Shipping is enabled automatically as a dependency.

## Verify it worked

Go to **Configuration → Web services → Commerce Novaposhta**
(`/admin/config/services/commerce-novaposhta`). If the settings form loads, the
module is installed — enter your API key there and then add a shipping method as
described in [Configuration](../configuration/index.md).
