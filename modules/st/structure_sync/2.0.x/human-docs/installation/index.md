# Installation

## Requirements

Structure Sync needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 7.1 or newer** (`php: >=7.1`).
- Core's **Taxonomy** (`taxonomy`), **Menu link content** (`menu_link_content`),
  and **Block** (`block`) modules — the three content types it syncs. These are
  part of Drupal core and are enabled automatically as dependencies.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/structure_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/structure_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en structure_sync -y
```

Grant the core **Administer site configuration** permission to any role that should
run sync operations (the module defines no permissions of its own).

## Submodules

Structure Sync ships **no submodules**.

## Verify it worked

Go to **Structure → Structure Sync** (`/admin/structure/structure-sync`). You
should see the general settings landing page with links to the taxonomies, blocks,
and menu‑links export/import screens. Continue to
[Configuration](../configuration/index.md) to run an export or import.
