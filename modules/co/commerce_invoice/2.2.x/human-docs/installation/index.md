# Installation

## Requirements

Commerce Invoice is an extension for Drupal Commerce and needs a working Commerce
store already in place.

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or newer** (`php: ^8.1`).
- **Drupal Commerce** `^2.37 || ^3` (`drupal/commerce`).
- **Entity Print** `^2.0` (`drupal/entity_print`) — used to render invoices as
  PDFs.

Composer will also pull in the other modules the invoice system relies on:
`commerce_order`, `commerce_price`, `commerce_store`, `commerce_number_pattern`,
`profile`, `state_machine`, `token`, and core's `file`. You do not install these
by hand — they come along as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_invoice -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — important here, since Commerce Invoice touches several
Commerce packages.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_invoice -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_invoice -y
```

Enabling it installs the two default invoice types (Invoice and Credit memo) and
their number patterns and workflow. To actually get invoices generated, configure
automatic generation on your order types — see
[Configuration](../configuration/index.md).

There are no submodules.
