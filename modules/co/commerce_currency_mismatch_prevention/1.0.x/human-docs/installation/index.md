# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Drupal Commerce 3**, with **Commerce** (`commerce`), **Commerce Cart**
  (`commerce_cart`), and **Commerce Order** (`commerce_order`) enabled — these are
  the module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_currency_mismatch_prevention -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/commerce_currency_mismatch_prevention -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_currency_mismatch_prevention -y
```

## Verify it worked

Go to **Commerce → Configuration → Store → Currency mismatch prevention**. You
should see the settings form with the behavior options described in
[Configuration](../configuration/index.md). Then try adding two products of
different currencies to one cart — the module should step in according to your
chosen behavior instead of throwing a currency‑mismatch error.
