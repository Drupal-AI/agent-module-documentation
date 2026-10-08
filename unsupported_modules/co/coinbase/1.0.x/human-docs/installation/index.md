# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- **Drupal Commerce** (`commerce`) and **Commerce Payment** (`commerce_payment`),
  which Composer pulls in as dependencies.
- A **Coinbase Commerce** account and an API key from it.

## Install with Composer

Note the Composer package name differs from the module's machine name — the
project is `coinbase_payment`:

```bash
composer require drupal/coinbase_payment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
including the Commerce modules, as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/coinbase_payment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `coinbase`:

```bash
drush en coinbase -y
```

This also enables Commerce and Commerce Payment if they are not already on.

## Verify it worked

Go to **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and start adding a new gateway — you
should see **Coinbase** available as a gateway plugin. Continue to
[Configuration](../configuration/index.md) to finish the setup.
