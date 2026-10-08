# Installation

## Requirements

Sync UUIDs needs:

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Configuration Manager** module (`config`), which the command works
  against.
- **Drush**, since the module's only interface is a Drush command.

There are no third-party Composer or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/sync_uuids -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sync_uuids -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sync_uuids -y
```

## Verify it worked

Confirm the command is available:

```bash
drush sync-uuids
```

(or the short alias `drush su`). Run it deliberately as part of a controlled
deployment or repair — ideally with a database backup in hand — then import your
configuration and confirm the previous UUID conflicts are gone.
