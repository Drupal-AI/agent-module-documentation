# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core **Media** (`media`) and **Path** modules.
- The **Entity Usage** (`entity_usage`) and **Multivalue Form Element** contrib
  modules — Composer installs these as dependencies.
- The module's own alt-text-import permission, granted to trusted editors.

## Install with Composer

From the project root:

```bash
composer require drupal/alt_text_import_csv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — this is what pulls in Entity Usage and Multivalue Form
Element.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alt_text_import_csv -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alt_text_import_csv -y
```

## Grant the permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant the
module's alt-text-import permission to the trusted roles that should run imports.
Because an import edits media across the whole site, grant it only to operators you
trust.

Once that's done, prepare and upload your CSV — see
[How to use it](../index.md#how-to-use-it).
