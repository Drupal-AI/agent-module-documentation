# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Commerce Payment** (`commerce_payment`) enabled — it ships with Drupal
  Commerce.
- A **CIB Bank merchant account** (a Shop ID / PID) and the **DES keyfiles** CIB
  issues for test and live use.
- Server access to place the keyfiles on disk at paths readable by the web server,
  and outbound network access to CIB's SAKI endpoints.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_cib -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_cib -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_cib -y
```

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and confirm you can add a gateway of
type **CIB**. Before you can transact, you must place the DES keyfiles on the server
and point the gateway at them — see [Configuration](../configuration/index.md) —
then run a test payment in test mode and confirm the server‑side close query marks
the order completed.
