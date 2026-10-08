# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce**, specifically the **Payment** module (`commerce_payment`).
- A **Midtrans account** (register at Midtrans) with your server and client keys.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_midtrans -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies and pull in the Midtrans PHP SDK.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_midtrans -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_midtrans -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
The **Midtrans** plugin should appear in the list. Continue to
[Configuration](../configuration/index.md) to enter your keys.
