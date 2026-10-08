# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.3 or newer** (`php: >=8.3`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/rename_admin_paths -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rename_admin_paths -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rename_admin_paths -y
```

Enabling the module changes nothing on its own — both prefix renames start switched
**off**. Head to [Configuration](../configuration/index.md) to turn on the renames you
want.

There are no submodules.

## A note on deployments

The rename settings are stored as configuration, so they export and import with
`drush config:export` / `config:import`. After importing renamed settings on another
environment, rebuild the router (`drush cr`) so the new prefixes take effect there.
