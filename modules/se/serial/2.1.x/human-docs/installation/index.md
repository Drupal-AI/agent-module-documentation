# Installation

## Requirements

Serial needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field** module (`field`) — its only dependency, and part of standard
  Drupal.
- A database that supports `AUTO_INCREMENT` columns (MySQL/MariaDB, which is the
  usual Drupal setup); the module relies on this for its atomic per-field counter
  tables.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/serial -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/serial -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en serial -y
```

Enabling the module makes the **Serial** field type available in the Field UI.
There is no settings page — the counter is created automatically the moment you add
a Serial field to a bundle (and its helper table is dropped again if you delete the
field). Add your first field by following
[How to use it](../index.md#how-to-use-it) in the overview.
