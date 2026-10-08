# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drush** — the base module is driven entirely from the command line.
- Required contrib dependencies (Composer pulls these in with `-W`):
  - Core **Migrate** (`migrate`)
  - **Migrate Plus** (`migrate_plus`)
  - **Migrate Source CSV** (`migrate_source_csv`)
  - **Migrate Skip on 404** (`migrate_skip_on_404`)

There are no third‑party Composer libraries beyond the modules above.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus,
Migrate Source CSV, Migrate Skip on 404, and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_generator -y
```

Drush will enable the required migration modules as dependencies if they aren't
already on.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Migrate generator export** | `migrate_generator_export` | Exports existing content **back to CSV**. Adds admin screens (config at `/admin/config/content/migrate-generator-export`, run at `/admin/content/migrate-generator-export`, gated by the **access csv export** permission) and export Drush commands. Enable only if you need the export direction. |

```bash
drush en migrate_generator_export -y
```

## Verify it worked

There is no admin page for the base module. Run
`drush migrate_generator:generate_migrations <absolute-csv-dir> --update`
against a folder of correctly named CSV files (see
[the module overview](../index.md#how-to-use-it)), then `drush migrate:status`
should list the freshly generated migrations under the `mgg` tag.
