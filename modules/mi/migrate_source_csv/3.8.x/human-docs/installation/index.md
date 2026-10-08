# Installation

## Requirements

- **Drupal 9.1 or newer** (`core_version_requirement: >=9.1`), including Drupal 10
  and 11.
- **PHP 7.1 or newer**.
- Core's **Migrate** module (`migrate`), which Drupal enables automatically as a
  dependency.
- The **`league/csv`** library (`^9.1`), a robust CSV reader that Composer installs
  for you.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_source_csv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the `league/csv` library automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_source_csv -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_source_csv -y
```

Enabling the module also enables core's Migrate module if it is not already on.

Most people also install **Migrate Tools** (`drupal/migrate_tools`) and, for
content migrations defined as config, **Migrate Plus** — these provide the
`drush migrate:import` / `migrate:rollback` commands you use to actually run a
migration:

```bash
composer require drupal/migrate_tools drupal/migrate_plus -W
drush en migrate_tools migrate_plus -y
```

## Next step

Migrate Source CSV has no UI. See [How to use it](../index.md#how-to-use-it) on the
overview page for a worked `source: plugin: csv` example.
