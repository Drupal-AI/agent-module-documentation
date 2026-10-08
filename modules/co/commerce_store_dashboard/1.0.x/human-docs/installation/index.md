# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Store** (`commerce_store`) — the only dependency; it comes with Drupal
  Commerce and Drupal will enable it automatically.

There are no third-party Composer libraries or a special PHP requirement beyond what
Commerce needs.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_store_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_store_dashboard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_store_dashboard -y
```

## Verify it worked

After enabling, visit `/store/{id}/dashboard` for one of your stores (replace `{id}` with a
real store ID) as a user who is allowed to see it. The dashboard page should render. It will
be empty until you lay it out — continue to [Configuration](../configuration/index.md) to
assign permissions and configure the dashboard view mode.
