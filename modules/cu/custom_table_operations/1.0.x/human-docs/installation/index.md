# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contributed modules, and no third‑party Composer or PHP library
  requirements — it depends only on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_table_operations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_table_operations -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_table_operations -y
```

After enabling, go to **People → Permissions** and grant the module's access
permission only to trusted administrator roles — it can edit database tables
directly.

## Verify it worked

Open the module's admin interface and confirm you can point it at one of your
project's custom (non-entity) database tables and see its rows. Remember the
project's warning: **do not add Drupal's core tables**. See
["How to use it"](../index.md#how-to-use-it) for the workflow.
