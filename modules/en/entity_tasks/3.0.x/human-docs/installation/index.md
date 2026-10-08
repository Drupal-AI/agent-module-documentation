# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies, no third‑party Composer packages, and no PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_tasks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_tasks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_tasks -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm the
Entity Tasks block is available to place. To set up the block and the optional
toolbar integration, continue to [Configuration](../configuration/index.md).
