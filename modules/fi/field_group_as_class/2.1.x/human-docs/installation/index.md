# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Field Group](https://www.drupal.org/project/field_group)** module
  (`drupal/field_group >= 1.0.0-rc6`). This is the module that provides field groups;
  Field Group as Class simply adds a new format to it. Composer pulls it in with the
  command below.
- Core's **Field** module (standard on any site with fields).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_as_class -W
```

This installs Field Group as Class together with its Field Group dependency. The
`-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group_as_class -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_as_class -y
```

Or enable **Field Group as Class** from *Extend* (`/admin/modules`). Drupal will
enable the Field Group module at the same time if it isn't already on.

There are no submodules and nothing to configure globally. After enabling, add a
field group and choose the **As Class** format on an entity's **Manage display** tab
— see [How to use it](../index.md#how-to-use-it).
