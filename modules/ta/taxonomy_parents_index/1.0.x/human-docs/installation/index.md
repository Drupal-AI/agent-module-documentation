# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (any site using vocabularies already has it). There are
  no other module or PHP library dependencies.

Note this project is currently **seeking a new maintainer** and is in maintenance-fix
mode, which is worth factoring into your decision for a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_parents_index -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_parents_index -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_parents_index -y
```

Enabling the module creates the `taxonomy_parents_index` table but does not populate
it — you build the index yourself from the reindex form, and then point a View at it.
Continue with [Configuration](../configuration/index.md).
