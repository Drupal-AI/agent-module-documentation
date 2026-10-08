# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Drupal Commerce** with the **Payment** module (`commerce_payment`) enabled —
  this is the only dependency; there are no additional PHP libraries.
- A **GMO Payment Gateway (Mul-Pay)** merchant account with LinkTypePlus
  credentials (shop ID and password).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_gmo_linktypeplus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_gmo_linktypeplus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_gmo_linktypeplus -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the **LinkTypePlus** plugin is available. Then follow
[Configuration](../configuration/index.md) to enter your GMO credentials, assign
the order workflow, and register the return URLs.
