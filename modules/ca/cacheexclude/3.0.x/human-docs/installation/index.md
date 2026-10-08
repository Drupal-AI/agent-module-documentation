# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- Core's **Path Alias** module (`path_alias`), enabled automatically as a
  dependency (the module tests both a page's internal path and its alias).

There are no third‑party Composer or PHP library requirements, and no permissions
are added — the settings form uses the core *Administer site configuration*
permission.

## Install with Composer

From the project root:

```bash
composer require drupal/cacheexclude -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cacheexclude -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cacheexclude -y
```

Nothing is excluded until you add rules on the settings form — see
[Configuration](../configuration/index.md).

This module has no submodules.
