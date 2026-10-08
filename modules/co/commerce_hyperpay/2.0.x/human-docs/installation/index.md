# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Drupal Commerce** with the **Payment** module (`commerce_payment`) enabled —
  this is the only dependency, and there are no additional PHP libraries.
- A **HyperPay / OPPWA merchant account** with an Authorization Bearer token and
  an Entity ID.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_hyperpay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_hyperpay -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_hyperpay -y
```

> **Upgrading?** The 2.0.x branch is a full revamp with API changes and **no
> upgrade path** from earlier versions — treat it as a fresh gateway
> configuration.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the **Hyperpay COPYandPAY Payment** plugin appears (and the Apple Pay
gateway, if you plan to use it). Then follow
[Configuration](../configuration/index.md).
