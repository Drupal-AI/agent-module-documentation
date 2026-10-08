# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Drupal Commerce Core 3** with Commerce **Payment** (`commerce_payment`) and
  Commerce **Order** (`commerce_order`) — enabled automatically as dependencies.
  There are no other requirements.
- A **Wise business account** to configure the integration. You can sign up for
  one on Wise's website.

## Install with Composer

This module should be added to your codebase via Composer. From the project root:

```bash
composer require drupal/commerce_wise -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed. You can also pin the branch with
`composer require "drupal/commerce_wise:^1.0"`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_wise -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_wise -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm **Wise Quick Pay** appears as a plugin. Continue with
[Configuration](../configuration/index.md).
