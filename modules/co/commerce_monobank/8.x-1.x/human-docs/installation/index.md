# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- **Drupal Commerce**, specifically the **Payment** module (`commerce_payment`) —
  Commerce Core.
- A **Monobank acquiring** registration (see below) and the merchant **X-Token**
  it provides.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_monobank -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_monobank -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_monobank -y
```

## Register Monobank acquiring

Before you can take payments, register for Monobank acquiring through Monobank to
obtain your merchant **X-Token**. You'll enter this token when configuring the
gateway.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The **Monobank** plugin should appear in the list. Continue to
[Configuration](../configuration/index.md) to enter your token.
