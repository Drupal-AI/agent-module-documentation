# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with its **Order** and **Payment** modules enabled
  (`commerce_order`, `commerce_payment`). Drupal enables these dependencies for
  you when you turn on this module.
- A **Banca Intesa Serbia (NestPay/Payten) merchant account** — you'll need your
  merchant ID, API username/password and the shared **store key** the bank
  issues.

The module also depends on the **`gnikolovski/gnikolovski_payment_log`** package
(used for request/response logging and the cron reconciliation of pending
orders). Composer installs it automatically as part of the require step below,
so there is nothing extra to download by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_banca_intesa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_banca_intesa -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_banca_intesa -y
```

## Verify it worked

Go to **Administration → Commerce → Configuration → Payment gateways**. Click
**Add payment gateway** and confirm that **Banca Intesa** appears in the list of
plugins. From there, continue to [Configuration](../configuration/index.md) to
enter your credentials.
