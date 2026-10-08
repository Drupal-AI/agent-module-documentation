# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No module dependencies are declared. It provides a block‑visibility condition,
  so you will naturally use it together with core's Block and (typically) Book
  modules.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/book_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/book_visibility -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en book_visibility -y
```

There are no submodules. Once enabled, the *book* visibility condition is
available in every block's configuration under **Structure → Block layout** — see
the [overview](../index.md#how-to-use-it).
