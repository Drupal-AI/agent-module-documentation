# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- **Views Bulk Operations** (`drupal/views_bulk_operations`, `^4.1`) — the LIST and
  UNMANAGED workflows use its bulk actions, so it is a hard dependency. Composer
  pulls it in automatically.
- Core's **Views** (`views`) and **Block** (`block`) modules — Drupal enables these
  as dependencies.

There are no third‑party Composer packages beyond the Views Bulk Operations
dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/fancy_file_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in `drupal/views_bulk_operations`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fancy_file_delete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fancy_file_delete -y
```

This enables Views Bulk Operations (and core Views/Block) at the same time and
installs two Views for the LIST and UNMANAGED workflows. After enabling, grant the
**Administer fancy file delete** permission and use the tool at **Configuration →
Content authoring → Fancy File Delete** — see
[How to use it](../index.md#how-to-use-it) on the overview page.

There are no submodules.
