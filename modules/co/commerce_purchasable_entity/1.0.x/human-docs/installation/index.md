# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** and two of its components:
  - **Commerce** (`commerce`)
  - **Commerce Price** (`commerce_price`)
  - **Commerce Store** (`commerce_store`)

These Commerce modules are pulled in automatically by Composer when you require
this module, and Drupal enables them as dependencies when you turn it on. There
are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_purchasable_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
Drupal Commerce and its shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_purchasable_entity -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_purchasable_entity -y
```

Enabling it also enables the Commerce dependencies if they are not already on.
Once active, the admin area for purchasable entities and their types appears
under Commerce's administration. See
[How to use it](../index.md#how-to-use-it) in the overview to wire a purchasable
type into an order item type and start selling.
