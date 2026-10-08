# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Pricelist** (`commerce_pricelist`) — this module adds scheduling on
  top of it, so it must be present and enabled. (Commerce Pricelist itself brings
  in Drupal Commerce.)

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_pricelist_schedule -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Commerce Pricelist is not already installed, requiring
this module will pull it in.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_pricelist_schedule -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_pricelist_schedule -y
```

## Verify it worked

Open any price-list page and look for a **Scheduled Imports** tab. If it is there,
the module is installed correctly. See
[How to use it](../index.md#how-to-use-it) on the overview page to schedule your
first import.

Because scheduled imports run on cron, make sure Drupal **cron** is running
regularly (via your server's scheduler or `drush cron`) so scheduled imports fire
at the expected time.
