# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Commerce Payment** (`commerce_payment`) from the
  [Drupal Commerce](https://www.drupal.org/project/commerce) suite.
- A **Billwerk+ / Reepay merchant account** with your **private API keys** (a
  live key and a test key).

There are no additional PHP library requirements declared by the module; API
calls use Guzzle, which ships with Drupal.

## Install with Composer

The Composer package name is `commerce_reepay` (this is the project name):

```bash
composer require drupal/commerce_reepay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_reepay -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module you enable is **not** the same as the project name. Enable
`commerce_reepay_checkout`:

```bash
drush en commerce_reepay_checkout -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the **Billwerk+ Payments** plugin appears in the list. Then continue to
[Configuration](../configuration/index.md).
