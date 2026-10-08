# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Price** (`commerce_price`, part of the Drupal Commerce project) —
  used for money amounts.
- Core **Views** (`views`).
- **Dynamic Entity Reference** (`dynamic_entity_reference`).
- **Views Data Export** (`views_data_export`) — used for the CSV export.

Composer pulls in the contributed dependencies (Commerce Price, Dynamic Entity
Reference, Views Data Export); core Views is enabled as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/bookkeeping -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
install the Commerce Price, Dynamic Entity Reference, and Views Data Export
dependencies and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bookkeeping -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bookkeeping -y
```

Enabling it will also enable its dependencies if they are not already on. There
are no submodules. After enabling, set up the permissions before letting anyone
in — see [Configuration](../configuration/index.md).
