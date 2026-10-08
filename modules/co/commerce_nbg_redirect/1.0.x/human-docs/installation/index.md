# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Drupal Commerce with **Payment** (`commerce_payment`) enabled — the only module
  dependency, enabled automatically.
- An **NBG / GlobalPayments merchant account** with the credentials for the hosted
  payment page. Google Pay and Apple Pay need to be activated and tested with your
  merchant account separately.

The module depends on the official **GlobalPayments PHP SDK**
(`globalpayments/php-sdk ^14.0.4`), which Composer installs automatically when you
require the module — no manual step needed.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_nbg_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_nbg_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_nbg_redirect -y
```

Commerce Payment is enabled automatically as a dependency.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways → Add payment gateway**
(`/admin/commerce/config/payment-gateways/add`). The plugin list should now include
**National Bank of Greece (Redirect)**. Configuring it is covered in
[Configuration](../configuration/index.md).
