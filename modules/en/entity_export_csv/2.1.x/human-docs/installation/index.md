# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third-party Composer or PHP library requirements, and no other module
  dependencies.

For access-controlled downloads it is best to have Drupal's **private filesystem**
configured; if it is not, exports fall back to the temporary filesystem and the
settings form will warn you.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_export_csv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_export_csv -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_export_csv -y
```

After enabling, visit the settings page to whitelist the entity types you want to
export — nothing can be exported until you do. See
[Configuration](../configuration/index.md). There are no submodules.
