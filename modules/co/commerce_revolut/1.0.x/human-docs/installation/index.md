# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Core 3** — specifically **Commerce Payment** (`commerce_payment`) and
  **Commerce Order** (`commerce_order`) from the
  [Drupal Commerce](https://www.drupal.org/project/commerce) suite. Drupal enables
  these as dependencies.
- A **Revolut Business (merchant) account**, or developer access to the account
  you intend to configure. You can sign up for a Revolut Business account on
  Revolut's site.

There are no other requirements beyond Commerce Core 3.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_revolut -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_revolut -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_revolut -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the **Revolut** plugin appears in the list. Then continue to
[Configuration](../configuration/index.md).
