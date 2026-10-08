# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`).
- **Migrate Plus** (`migrate_plus`).
- **Migrate Drupal** (`migrate_drupal`).

The module also works alongside **Migrate Tools** (`migrate_tools`) for running
migrations from Drush. There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/edw_migrate_d7 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Migrate Plus / Migrate Drupal dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/edw_migrate_d7 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edw_migrate_d7 -y
```

Drupal will enable the Migrate dependencies if they are not already on. You will
typically also want Migrate Tools enabled to run migrations:

```bash
drush en migrate_tools -y
```

## Verify it worked

There is no UI to check. Confirm the module is enabled (`drush pml | grep
edw_migrate_d7`), then reference its helper classes from your migration
definitions and run a migration with Migrate Tools (for example
`drush migrate:import <id>`) to see them in use.
