# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — Drupal enables it automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements (HTTP requests use
Guzzle, which ships with Drupal core).

## Install with Composer

From the project root:

```bash
composer require drupal/views_json_source -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_json_source -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_json_source -y
```

Once enabled, **JSON** becomes available as a base for new Views. There are no
permissions to grant beyond the standard "administer site configuration" that already
governs the Views UI and the module's small settings page. See the
[main guide](../index.md#how-to-use-it) to build your first JSON‑backed view.

This module ships no submodules.
