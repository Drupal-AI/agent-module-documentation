# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** with the **Commerce Payment** module (`commerce_payment`)
  enabled.
- The **`yabacon/paystack-php`** PHP library, installed via Composer. The module
  checks for it and reports itself as not ready (via `hook_requirements`) if it is
  missing.
- A **Paystack account** with API keys (test keys start with `sk_test_`, live keys
  with `sk_live_`).

## Install with Composer

From the project root, requiring the module also pulls in the Paystack PHP
library as a dependency:

```bash
composer require drupal/commerce_paystack -W
```

If for any reason the library is not present, add it explicitly:

```bash
composer require yabacon/paystack-php
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_paystack -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_paystack -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. If
**Paystack Standard (Off-site)** appears among the plugins, the module and its
library are installed correctly. Continue to
[Configuration](../configuration/index.md).
