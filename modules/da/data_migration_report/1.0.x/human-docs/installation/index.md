# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Migrate Drupal** (`migrate_drupal`), a core module — it is a dependency and
  Drupal enables it automatically when you turn on Data Migration Report. (Core's
  Migrate module comes with it.)
- **Drush** — the module's features are exposed as Drush commands.
- **Access to your source database** (the Drupal 7 site you are migrating from),
  configured as described in [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/data_migration_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/data_migration_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en data_migration_report -y
```

This also enables core's Migrate Drupal module if it is not already on.

## Verify it worked

Confirm the module's Drush commands are registered:

```bash
drush list --filter=migration
```

You should see `migration:test` (and `generate:content-mapping`) listed. Before
running them for real, set up the source database connection — see
[Configuration](../configuration/index.md).
