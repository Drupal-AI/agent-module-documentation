# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) — while not listed as a hard install
  dependency, the whole feature relies on a View to supply the filtered options,
  so Views must be enabled for the module to do anything useful.

There is no PHP version requirement and there are no third-party Composer
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/dependent_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dependent_fields -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dependent_fields -y
```

Make sure **Views** is enabled too (`drush en views -y` if needed). Once enabled,
the new **"Make field dependent using views"** reference method appears when you
edit an entity-reference field — see [Configuration](../configuration/index.md).

There are no submodules.
