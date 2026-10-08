# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Field UI** (`field_ui`) module — Drupal enables it automatically as a
  dependency when you turn on Entity Admin Handlers.
- **Recommended:** apply the core patch from
  [drupal.org issue #2976861](https://www.drupal.org/project/drupal/issues/2976861)
  so the generated menu, task, and action links work. The routes function without
  the patch; only the links depend on it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_admin_handlers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_admin_handlers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_admin_handlers -y
```

## Verify it worked

This is a developer building block, so enabling it alone produces no visible change.
It takes effect once a custom entity type references its handlers from that entity
type's definition in code. After you wire it up and rebuild caches, your entity
type should gain its admin management routes (and, with the recommended core patch
applied, the accompanying menu, task, and action links).
