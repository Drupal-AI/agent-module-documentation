# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4||^10||^11`).
- A **Bootstrap Barrio‑based theme** to apply the colors to — this is what the
  module recolors. Not a Composer dependency, but the module is only useful with
  such a theme.
- No module dependencies are declared. The module provides its own permission.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_colors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_colors -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_colors -y
```

There are no submodules. After enabling, grant its permission and configure the
color palette — see the [overview](../index.md#how-to-use-it).
