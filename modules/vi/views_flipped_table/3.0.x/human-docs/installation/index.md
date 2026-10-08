# Installation

## Requirements

Views Flipped Table is a small, core‑only add‑on:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`), enabled — it is the only dependency, and it is
  part of the standard install.

There are no third‑party Composer packages or PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/views_flipped_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_flipped_table -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_flipped_table -y
```

Or enable **Views Flipped Table** from **Extend** (`/admin/modules`).

There are no submodules and no configuration form. Once enabled, the **Flipped Table**
format is immediately available in the Views UI — see
[How to use it](../index.md#how-to-use-it) on the overview page.
