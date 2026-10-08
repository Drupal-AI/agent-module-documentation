# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.

The module has most effect when Drupal's **CSS/JS aggregation** is enabled
(**Configuration → Development → Performance**), since it operates on the
aggregated asset files.

## Install with Composer

From the project root:

```bash
composer require drupal/asset_cache_bust -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/asset_cache_bust -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en asset_cache_bust -y
```

That is all it takes — there is no settings form. Once enabled, the module adds a
cache‑busting query string to aggregated CSS and JS automatically. See
[How to use it](../index.md#how-to-use-it).

This module has no submodules.
