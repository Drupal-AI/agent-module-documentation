# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No third‑party module, Composer, or PHP library requirements. Grids render your
  fields using their existing display formatters, so having **Field UI** enabled is
  handy for controlling which fields appear.

## Install with Composer

From the project root:

```bash
composer require drupal/autogrid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autogrid -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autogrid -y
```

The module ships no submodules. Once enabled, head to
[Configuration](../configuration/index.md) to choose which entity types get a grid
and to grant the viewing permission.
