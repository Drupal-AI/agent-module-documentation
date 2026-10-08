# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 7.3 or newer** (`^7.3 || ^8.0`).
- The **Address** module (`drupal/address`, `^1.0 || ^2.0`) — this module extends
  Address fields, so it must be present. Composer pulls it in for you.
- **Optional:** the [Token](https://www.drupal.org/project/token) module — when
  enabled, the map link text can use tokens.

## Install with Composer

From the project root:

```bash
composer require drupal/address_map_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Address module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_map_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_map_link -y
```

There are no submodules and no permissions of its own. Once enabled, the map‑link
options appear in the formatter settings of any Address field — see the
[main page](../index.md) for how to turn them on. There is no settings form to
visit.
