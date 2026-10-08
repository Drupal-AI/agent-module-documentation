# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal Commerce with **Payment** (`commerce_payment`) enabled.
- **Phone International** (`phone_international`) — Opayo's 3‑D Secure requires a
  customer phone number in international format.
- **Queue Unique** (`queue_unique`) — used by the module's cron reconciliation.
- An **Opayo (Elavon) merchant account** with a vendor name and live/test
  integration keys and passwords.

Composer resolves the `phone_international` and `queue_unique` dependencies for you.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_opayo_pi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`phone_international` and `queue_unique` dependencies and update shared packages as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_opayo_pi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_opayo_pi -y
```

Commerce Payment, Phone International and Queue Unique are enabled automatically as
dependencies.

## Verify it worked

Go to **Commerce → Configuration → Opayo Pi settings**
(`/admin/commerce/config/opayo_pi/settings`). If the settings form loads, the module
is installed — enter your Opayo credentials there and then add the payment gateway
and checkout flow as described in [Configuration](../configuration/index.md).
