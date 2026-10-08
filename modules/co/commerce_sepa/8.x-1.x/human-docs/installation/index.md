# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Drupal **Commerce** with the **Payment** module (`commerce_payment`) enabled.
- A store operating in the euro area with a **SEPA creditor identifier** so you
  can raise valid direct-debit mandates.
- The **`globalcitizen/php-iban`** library (`^2.6`), used to validate IBANs.
  Installing the module with Composer pulls it in automatically; sites that do
  not use Composer can install it via
  [Ludwig](https://www.drupal.org/project/ludwig) instead.

There is no additional PHP version requirement beyond what Drupal core needs.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_sepa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_sepa -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_sepa -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the **SEPA** plugin is offered. Then continue to
[Configuration](../configuration/index.md).
