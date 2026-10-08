# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Views** module (`views`) enabled — the only dependency.
- One or more **extra database connections** defined in `settings.php` (this is
  what VDC exposes to Views). Supported drivers: MySQL, SQLite, PostgreSQL, and SQL
  Server (`sqlsrv`/`odbc`).

There are no third-party libraries and no Drush commands.

## Install with Composer

From the project root:

```bash
composer require drupal/views_database_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_database_connector -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_database_connector -y
```

## After enabling

VDC does nothing until you have an extra database connection in `settings.php` and
have chosen which connections it may expose. Head to
[Configuration](../configuration/index.md) for the full setup, and note the tip
there about rebuilding Views data after you change database configuration.
