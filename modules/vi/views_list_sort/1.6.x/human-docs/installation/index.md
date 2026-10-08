# Installation

## Requirements

Views List Sort is tiny and has no third‑party requirements. It needs:

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10.0 || ^11`).
- Core's **Views** module (`views`) enabled — Drupal enables it automatically as
  a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/views_list_sort -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_list_sort -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_list_sort -y
```

That's all. There is no configuration form. The new sort behavior becomes
available automatically for every List (text) field — see
[How to use it](../index.md#how-to-use-it) to turn it on inside a View.
