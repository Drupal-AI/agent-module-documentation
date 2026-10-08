# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Field Group** module (`field_group`) — a hard dependency; Composer pulls
  it in for you. This module is a formatter *for* Field Group.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_markup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Field Group and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group_markup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_markup -y
```

Drupal enables the **Field Group** module at the same time as a dependency.

There is no configuration form. The new **Markup** field‑group format is now
available on any entity's *Manage form display* or *Manage display* tab — see
[How to use it](../index.md#how-to-use-it).
