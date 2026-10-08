# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) — enabled on every standard Drupal site and
  pulled in automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_update_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bulk_update_fields -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_update_fields -y
```

On install the module automatically creates a bulk‑update action for each entity
type, so the "Bulk Update … Fields" action shows up on the content listing right
away. There are no submodules.

## After enabling

1. Grant the **Administer bulk_update_fields** permission to the roles that should
   be able to run mass edits, at **People → Permissions**.
2. Optionally build an exclude list so sensitive fields can't be bulk‑overwritten
   — see [Configuration](../configuration/index.md).
