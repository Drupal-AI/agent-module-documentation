# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal **Commerce** `^2.0 || ^3.0` with the **Payment** module
  (`commerce_payment`) enabled.
- The **`commerceredsys/sermepa` `^1.0.9`** library, which implements the Redsýs
  protocol (signing and verification). Composer installs this automatically.
- A **Redsýs merchant account** with a Spanish bank, which gives you the merchant
  code, terminal number, and secret merchant key.

## Install with Composer

Composer is the recommended way to install, because it also pulls in the Redsýs
protocol library. From the project root:

```bash
composer require drupal/commerce_sermepa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_sermepa -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

> The module also ships a `ludwig.json`, so the protocol library can be installed
> without Composer on hosts that require that — but Composer is the recommended
> path.

## Enable the module

```bash
drush en commerce_sermepa -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), click **Add payment gateway**, and
confirm the **Sermepa / Redsýs** plugin is offered. Then continue to
[Configuration](../configuration/index.md).
