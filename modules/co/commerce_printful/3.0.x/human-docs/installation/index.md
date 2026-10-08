# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`). Note that
  version 3.x targets **Commerce 3.x** and Drupal 11; the older Drupal 10 /
  Commerce 2.x line is no longer supported from 3.0.0.
- **Drupal Commerce** (`commerce`, 3.x) — the core dependency. The module also
  depends on **Commerce Shipping** (`commerce_shipping`) and **Commerce Currency
  Resolver** (`commerce_currency_resolver`), which are separate contrib projects, so
  require them alongside it. You will also want a working **payment gateway** of your
  choice so you can collect payment from customers.
- A **Printful account** with an **API key**, and a card on file with Printful
  (Printful bills you per order).

There are no additional PHP library requirements beyond those contrib modules.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_printful -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_printful -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_printful -y
```

Enabling the module makes its **permissions** and **Drush commands** available.
Review the permissions at **People → Permissions** and grant the Printful
administration permission to the roles that should manage the integration.

## Verify it worked

After enabling, you should be able to reach the module's Printful settings/connect
pages in the admin UI and enter your API key. Once connected, the product import
tools (UI and Drush command) become usable. Continue to
[Configuration](../configuration/index.md) to connect your account and import
products.
