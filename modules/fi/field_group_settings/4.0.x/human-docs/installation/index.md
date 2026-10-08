# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[Field Group](https://www.drupal.org/project/field_group)** module
  (`drupal/field_group ^3 || ^4`) — this module is a formatter that plugs into it.
  Composer pulls it in for you.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_settings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Field Group and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group_settings -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_settings -y
```

There are no submodules. Once enabled, a new **Settings** format becomes available
when you add a field group on a **Manage form display** tab — see
[Configuration](../configuration/index.md).
