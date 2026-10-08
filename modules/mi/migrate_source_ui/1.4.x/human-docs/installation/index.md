# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** and **Migrate** modules (enabled as dependencies).
- The contributed **Migrate Tools** module (`drupal/migrate_tools ^6.1`), pulled in
  by Composer.

To actually import files you'll also want the source module(s) for the file types
you use. These are **suggested**, not required, so add whichever you need:

- **Migrate Plus** (`drupal/migrate_plus ^6`) — needed for JSON and XML URL
  sources, and the usual way to author migrations as configuration.
- **Migrate Source CSV** (`drupal/migrate_source_csv ^2.2 || ^3.0`) — for CSV
  sources.
- **Migrate Spreadsheet** (`drupal/migrate_spreadsheet ^2`) — for spreadsheet
  sources.

A migration only appears on the run page if its source plugin comes from one of
these modules, so install the ones matching the files you plan to upload.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_source_ui -W
```

Add the source modules you need alongside it, for example:

```bash
composer require drupal/migrate_plus drupal/migrate_source_csv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
(such as Migrate Tools) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_source_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_source_ui -y
```

Drupal enables Migrate and Migrate Tools at the same time. Enable your source
modules too, for example `drush en migrate_plus migrate_source_csv -y`.

## Verify it worked

Grant the permissions (see [Configuration](../configuration/index.md)), then visit
**Content → Migrate Source UI** (`/admin/content/migrate_source_ui`). If you have
authored at least one file-based migration and enabled its source module, it should
appear in the list ready to run.
