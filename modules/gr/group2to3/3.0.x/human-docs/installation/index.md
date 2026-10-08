# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Group** module (`group`) — this tool operates on Group's data.
- A **full database backup** and a configuration export (`drush cex`) taken
  before you run the upgrade. This module changes and deletes data.

## Install with Composer

Install this module while your site is still on **Group 2.x**, from the project
root:

```bash
composer require drupal/group2to3 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group2to3 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group2to3 -y
```

## Run the upgrade

With the module enabled, move Composer to Group 3.x and run the database updates:

```bash
composer require drupal/group:^3.0 -W
drush updb
```

The migration pipeline runs during `drush updb`. Because it is progress‑tracked,
a large migration can span several batch iterations and resume safely.

## Clean up afterwards

This is a one‑shot tool. Once you have verified the upgraded groups and exported
the migrated configuration (`drush cex`), uninstall and remove it:

```bash
drush pmu group2to3 -y
composer remove drupal/group2to3
```

## Verify it worked

After `drush updb` finishes, confirm your groups still exist, that group content
now appears as **group relationships**, and that any Views which referenced
`group_content` still return the expected results. Only remove the module once
you are satisfied the migration is complete and correct.
