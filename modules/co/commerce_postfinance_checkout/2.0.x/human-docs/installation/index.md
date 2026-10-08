# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drupal Commerce** with the **Commerce Payment** (`commerce_payment`) and
  **Commerce Price** (`commerce_price`) modules enabled.
- A **PostFinance contract** and a PostFinance Checkout **space**, which provides
  your space id, user id, and API credentials.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_postfinance_checkout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_postfinance_checkout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_postfinance_checkout -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**. If
the **PostFinance** plugin appears among the choices, the module is installed
correctly. Continue to [Configuration](../configuration/index.md).
