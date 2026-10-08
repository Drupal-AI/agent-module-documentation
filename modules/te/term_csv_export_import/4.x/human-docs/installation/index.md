# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** and **System** modules enabled — Taxonomy is the module you
  are importing/exporting terms for, and both are enabled automatically as
  dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/term_csv_export_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_csv_export_import -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_csv_export_import -y
```

## Grant the permission

Both forms are controlled by one permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant **Administer CSV Term Import**
(`administer term_csv_export_import`) to trusted administrators only — importing can
create and modify taxonomy content, and (when importing with IDs) write term IDs
directly into the taxonomy tables.

## Next step

See [Configuration](../configuration/index.md) for a walkthrough of the import and
export forms and the CSV format.
