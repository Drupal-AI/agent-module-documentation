# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- Commerce's **Payment** module (`commerce_payment`) — Drupal enables it
  automatically as a dependency when you turn on Commerce VNPay. This in turn
  means you need a working **Drupal Commerce** installation.
- A **VNPay merchant account** with your terminal code (`vnp_TmnCode`) and hash
  secret (`vnp_HashSecret`).

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_vnpay_payment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_vnpay_payment -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_vnpay_payment -y
```

## Verify it worked

The gateway does nothing until you configure it. Go to **Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`)
and click **Add payment gateway** — you should see **VNPay** in the list of
plugins. Continue with [Configuration](../configuration/index.md) to enter your
credentials, and read the security caveat in the [overview](../index.md) before
using this gateway for real payments.
