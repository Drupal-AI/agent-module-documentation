# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Drupal core's **Migrate** module (`migrate`).
- **Migrate Plus** (`migrate_plus`) and **Migrate Tools** (`migrate_tools`) —
  contributed modules that Composer will pull in with the command below.
- A **source database** connection defined in `settings.php` (the database you're
  migrating from).
- No third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_sql_migrate_source_plugin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Migrate Plus and Migrate Tools.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_sql_migrate_source_plugin -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_sql_migrate_source_plugin -y
```

Enable your own migration module (the one containing your `custom_sql_query`
migration) the same way.

## Verify it worked

Define a migration that uses the `custom_sql_query` source plugin (see
["How to use it"](../index.md#how-to-use-it)), make sure the source database is
connected in `settings.php`, then run the migration with Drush (for example
`drush migrate:import <migration_id>`). Confirm the imported rows contain the
columns your `SELECT` returned.
