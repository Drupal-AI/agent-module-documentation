# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** (`taxonomy`) module, enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/terms_export_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/terms_export_import`)
matches the module's machine name (`terms_export_import`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/terms_export_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en terms_export_import -y
```

## Verify it worked

Visit the export page at `/admin/config/terms-export` and the import page at
`/admin/config/terms-import`. Both should load. See the [main guide](../index.md)
for the export‑edit‑import workflow — and keep these pages restricted to trusted
administrators, since importing a CSV creates and updates real taxonomy terms.
