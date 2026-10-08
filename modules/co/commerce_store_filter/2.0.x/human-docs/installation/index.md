# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal Commerce** (`commerce`) and **Commerce Store** (`commerce_store`).
- Core **Views** (part of Drupal core) — the module adds a Views contextual filter.

Composer will fetch the Commerce dependencies for you. This module is most useful on sites
that actually run more than one store.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_store_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_store_filter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_store_filter -y
```

## Verify it worked

After enabling, the Commerce Store Switch block is available in **Structure → Block layout**
(`/admin/structure/block`), and the store contextual filter can be added when editing a View
at **Structure → Views**. See "How to use it" in the [overview](../index.md) for placing the
block and adding the filter.
