# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal module, Composer, or PHP library dependencies.
- **Drush** if you want to use the command‑line output as well as the admin pages.
- MySQL or MariaDB (the reports read `INFORMATION_SCHEMA` and use `DESCRIBE` /
  `SHOW INDEX`).

## Install with Composer

From the project root:

```bash
composer require drupal/database_info_schema -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/database_info_schema -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en database_info_schema -y
```

## Access to the pages

The pages `/admin/database/info` and `/admin/database/table/{tablename}` are gated by
the core **`access content`** permission. Since that permission is broadly granted,
decide who in your environment should be able to see the database's structural and
storage details, and on shared or production sites restrict the routes to an
administrative permission before relying on the module.

## Verify it worked

Visit **`/admin/database/info`**. You should see the list of database tables;
clicking a table shows its columns, indexes, and row count. If those pages load, the
module is working.
