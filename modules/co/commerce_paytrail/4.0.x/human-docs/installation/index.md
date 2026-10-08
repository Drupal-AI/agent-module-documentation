# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Payment** module (`commerce_payment`)
  enabled — the only module dependency.
- A **Paytrail merchant account**, which gives you the merchant credentials
  (including the merchant secret used to sign and verify callbacks).

The module requires **PHP 8.1+** and pulls in the official **Paytrail PHP SDK**
(`paytrail/paytrail-php-sdk ^2.0`) and Drupal Commerce (`drupal/commerce ^2 || ^3`).
Composer resolves these for you when you require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_paytrail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_paytrail -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_paytrail -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. If
the Paytrail plugin appears among the choices, the module is installed correctly.
Continue to [Configuration](../configuration/index.md).
