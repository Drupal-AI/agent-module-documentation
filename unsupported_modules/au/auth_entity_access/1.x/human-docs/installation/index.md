# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No module dependencies and no third-party Composer or PHP library requirements are
  declared.

Note that the tracked release is a development version (`1.x-dev`).

## Install with Composer

From the project root:

```bash
composer require drupal/auth_entity_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auth_entity_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auth_entity_access -y
```

## Next steps

There is no settings page. Grant the **`configure auth entity access`** permission to
the roles that should be allowed to restrict nodes, then use the per-node checkbox on
the node edit form — see [How to use it](../index.md#how-to-use-it).
