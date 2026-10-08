# Installation

## Requirements

- **Drupal 8.9+, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — the only dependency, and typically already on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_exposed_filter_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_exposed_filter_blocks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_exposed_filter_blocks -y
```

There is no global configuration. To use it, place the filter block from **Block layout** and
choose a view/display — see the [overview guide](../index.md#how-to-use-it).

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place block** in any
region: searching for *Views exposed filter block* (category *Views Exposed Filter Blocks*)
should return the module's block, ready to place.
