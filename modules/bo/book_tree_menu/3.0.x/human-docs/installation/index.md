# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Book** module (`book`) enabled — Drupal enables it automatically as a
  dependency. The module is only useful on a site that actually uses books.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/book_tree_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/book_tree_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en book_tree_menu -y
```

There are no submodules. Once enabled, place its book‑tree block from
**Structure → Block layout** as described in the
[overview](../index.md#how-to-use-it).
