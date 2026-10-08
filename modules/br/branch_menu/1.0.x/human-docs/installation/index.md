# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`). This module targets Drupal 11
  only.
- No other module dependencies, and no third-party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/branch_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/branch_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en branch_menu -y
```

Once enabled, grant the module's permission to the roles that should be able to
use the visualization, then point it at one of your existing menus — see the
[overview](../index.md#how-to-use-it).
