# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush**, since the module is driven entirely from the command line.
- No other module dependencies and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_csv_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bulk_csv_delete -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_csv_delete -y
```

Once enabled, the module's Drush command is available. Prepare and verify your
CSV of entity ids, back up your database, and run the command — see
[How to use it](../index.md#how-to-use-it). Remember it deletes whatever ids you
give it, with no access check and no undo.
