# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or higher**.
- **Drupal Commerce 3.x** — specifically the `commerce_product` and `commerce_price`
  modules (plus core's `system`). Commerce is a hard dependency.
- A **Clover merchant account** with an API token (see
  [Configuration](../configuration/index.md)).

### Optional

- **[Commerce Stock](https://www.drupal.org/project/commerce_stock) 3.x** — when
  installed, stock is managed through the Commerce Stock transaction API. Without
  it, the module falls back to writing stock onto a plain integer field on the
  product variation (whose machine name you set in the settings form).

## Install with Composer

From the project root:

```bash
composer require drupal/clover_commerce_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Commerce's shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clover_commerce_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en clover_commerce_sync -y
```

## Verify it worked

Go to **Commerce → Clover Sync** (`/admin/config/commerce/clover-sync`). You should
see the settings form. Nothing syncs until you enter your Clover credentials and
your product SKUs line up — continue to [Configuration](../configuration/index.md).
