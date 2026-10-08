# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Payment** (`commerce_payment`) and **Checkout**
  (`commerce_checkout`) modules enabled. (The module also works with the Cart and
  Product modules that a Commerce store already runs.)
- A **GoCardless account**. The module is provided through Seamless-CMS, a
  GoCardless partner; sites using it operate as clients of Seamless, which works
  with the client site to generate the payments, subscriptions and mandates.

There are **no third-party PHP libraries** to install — installation is
deliberately simple.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_gc_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_gc_client -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_gc_client -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the **GoCardless** plugin appears. Then continue to
[Configuration](../configuration/index.md) to enter your credentials and register
the webhook.
