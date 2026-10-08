# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.

Before using it in earnest, make sure you have a **backup of your files
directory** — the module deletes assets permanently. See
[Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/asset_purge_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/asset_purge_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en asset_purge_manager -y
```

After enabling, grant the module's purge permission (**People → Permissions**)
only to trusted administrators. Then review what a purge would remove before
running it — see [Configuration](../configuration/index.md). A safe first step is
to try it on a staging copy of the site.

This module has no submodules.
