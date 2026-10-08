# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Several **core modules**, which a standard Drupal install already provides:
  Configuration Manager (`config`), Field (`field`), System (`system`), Field UI
  (`field_ui`), Menu UI (`menu_ui`), and User (`user`). Drupal enables any that are
  off as dependencies.
- The **`phpoffice/phpspreadsheet`** library (version `^3.5`), which the module
  pulls in via Composer and which powers the XLSX export.

Because of the PhpSpreadsheet dependency, install the module with Composer rather
than by downloading a zip.

## Install with Composer

From the project root:

```bash
composer require drupal/structure_map -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in PhpSpreadsheet and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/structure_map -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en structure_map -y
```

There is no configuration step — the module is ready to use as soon as it is
enabled.

## Verify it worked

Go to **Structure → Structure Map** (`/admin/structure/map`). Select an entity
type and bundle in the filter form; you should see a table describing that
bundle's fields, displays, and editorial permissions. To confirm the export works,
visit **Structure Map → Export** (`/admin/structure/map/export`) and generate a
spreadsheet — if PhpSpreadsheet installed correctly, the XLSX downloads.
