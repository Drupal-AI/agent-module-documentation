# Installation

## Requirements

Node Export has minimal requirements:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP newer than 7.0**, with the **JSON extension** (`ext-json`) — this is
  standard on virtually every Drupal host.

It relies only on core's node system, so there are no contrib module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/node_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/node_export -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_export -y
```

After enabling, grant the module's permissions to the roles that need them (see
[Configuration → Permissions](../configuration/index.md#permissions)), because the
export and import pages are locked down by default.

This module ships no submodules.
