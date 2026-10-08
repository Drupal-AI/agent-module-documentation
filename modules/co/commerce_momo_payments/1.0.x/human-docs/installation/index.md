# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- **Drupal Commerce** (`commerce`) and its **Payment** module
  (`commerce_payment`).
- A **MoMo merchant account** with a partner code, access key, and secret key
  (test and live).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_momo_payments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_momo_payments -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_momo_payments -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The **MoMo Wallet**, **MoMo Pay with ATM**, and **MoMo Credit Card** plugins
should appear in the list. Continue to [Configuration](../configuration/index.md)
to enter your credentials.
