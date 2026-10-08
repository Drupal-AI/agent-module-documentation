# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- **Drupal Commerce** (`commerce`) and Commerce **Payment**
  (`commerce_payment`) — enabled automatically as dependencies. For Drupal 9 and
  above use the **2.0.x** branch.
- A **Winbank / Piraeus Bank merchant account** with your acquiring credentials.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_winbank_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed. You can also pin the branch explicitly with
`composer require 'drupal/commerce_winbank_redirect:^2.0'`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_winbank_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_winbank_redirect -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm **Winbank** appears as a plugin. Continue with
[Configuration](../configuration/index.md), and consult the module's README for
the exact callback URLs you need to register with Piraeus Bank.
