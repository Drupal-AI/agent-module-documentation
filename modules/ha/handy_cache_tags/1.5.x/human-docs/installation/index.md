# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/handy_cache_tags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/handy_cache_tags -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en handy_cache_tags -y
```

That is the entire setup. There is no configuration page and nothing to turn on —
once enabled, the module is ready for your code to use its services. From this
point the automatic entity‑CRUD invalidation is active, and you can start
attaching the handy tags to your render arrays (see the
[overview](../index.md#how-to-use-it)).

## Verify it worked

Confirm the manager service is available:

```bash
drush ev "var_dump(\Drupal::service('handy_cache_tags.manager')->getBundleTag('node','article'));"
```

This should print `handy_cache_tags:node:article`.
