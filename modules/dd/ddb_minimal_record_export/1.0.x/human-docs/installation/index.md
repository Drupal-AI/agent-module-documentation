# Installation

## Requirements

- **Drupal 10.2+ or Drupal 11** (`core_version_requirement: ^10.2 || ^11`).
- Any **fieldable content entity type** to export from. [WissKI](https://www.drupal.org/project/wisski)
  (entity type `wisski_individual`) is a typical companion but is optional — any
  content entity type is supported.

There are no third‑party PHP library requirements; the LIDO/MDS XSD used for
validation is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ddb_minimal_record_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ddb_minimal_record_export -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ddb_minimal_record_export -y
drush cr
```

You can also enable it from **Administration → Extend**. A cache rebuild (`drush
cr`) is recommended so the per-entity export routes register.

## Grant the permissions

At **People → Permissions** (`/admin/people/permissions`), assign:

- **Administer DDB Minimal Record mapping** — configure mappings, catalog versions,
  and global defaults, and export the config/schema. This is a powerful,
  trusted-admin permission.
- **Export DDB Minimal Record LIDO** — run single-entity and bulk LIDO exports.

## Verify it worked

Log in as an administrator with the mapping permission and go to **Configuration →
Export → DDB Minimal Record** (`/admin/config/export/ddb-minimal-record`). You
should see the settings/mapping area. Continue to
[Configuration](../configuration/index.md) to set up the entity type, MDS catalog,
and field mapping.
