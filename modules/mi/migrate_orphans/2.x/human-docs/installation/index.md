# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`).
- The contributed **Migrate Plus** module (`drupal/migrate_plus`).
- The contributed **Migrate Tools** module (`drupal/migrate_tools`), **version
  6.0.4 or newer**.

There are no additional PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_orphans -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus and
Migrate Tools and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_orphans -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_orphans -y
```

Drupal enables core Migrate, Migrate Plus, and Migrate Tools automatically as
dependencies if they are not already on.

## Verify it worked

Confirm the module is enabled (**Extend** page, or
`drush pm:list --status=enabled`). The Drush commands `migrate:orphans-purge` and
`migrate:orphans-disable` should now be available — check with
`drush list --filter=migrate`. There is no configuration form to fill in; see the
[overview page](../index.md) for how to run the commands safely.
