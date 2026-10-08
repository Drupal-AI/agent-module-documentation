# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core **Taxonomy** module (`taxonomy`) — enabled automatically as a dependency.
- No special requirements; nothing outside Drupal core is needed.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_fast_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_fast_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_fast_import -y
```

## Set permissions

The module provides its own permission for using the import screen. Because the
tool bulk‑creates (and can delete) taxonomy terms, grant that permission only to
trusted editors or administrators at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Go to **Structure → Taxonomies Fast Import** (`/admin/structure/quick_import`).
If the import screen loads with a vocabulary selector and a text area for the
term list, the module is installed correctly. See the
[main guide](../index.md) for the import format.
