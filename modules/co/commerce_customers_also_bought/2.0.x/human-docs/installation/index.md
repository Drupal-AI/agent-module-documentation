# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core **Block** (`block`) enabled — Drupal enables it automatically as a
  dependency.
- **Drupal Commerce** (`commerce`) — a required module dependency declared in the
  module's `.info.yml`. Note the module's `composer.json` does *not* list
  `drupal/commerce`, so Commerce must already be installed in your project;
  otherwise Drupal will not let you enable this module.
- A Drupal Commerce store with order history (the recommendations are computed
  from past orders).

There are no third‑party Composer or PHP library requirements beyond Drupal
Commerce itself.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_customers_also_bought -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_customers_also_bought -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_customers_also_bought -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block**. The **Commerce Customers Also Bought** block should be available to
place. See "How to use it" in the [overview](../index.md) for setting the number
of products and the view mode.
