# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- A **LiqPay merchant account** with API credentials — a public/private key pair
  for live and a separate pair for sandbox. Get them from your LiqPay dashboard.
- Optional: the **Basket** commerce module, if you want LiqPay to appear as a
  payment method inside Basket's checkout. It is not required — the module also
  works standalone.
- There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/liqpay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/liqpay -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en liqpay -y
```

Enabling the module creates its `payments_liqpay` database table and registers
the settings form and checkout/callback routes.

## After enabling

There are no submodules. Grant the **Access LiqPay settings** permission (a
restricted permission) only to trusted administrators at **People → Permissions**,
then configure your keys and options — see
[Configuration](../configuration/index.md).
