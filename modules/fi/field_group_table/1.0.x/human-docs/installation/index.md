# Installation

## Requirements

Field Group Table extends the Field Group module, so it needs it:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **[Field Group](https://www.drupal.org/project/field_group)** (`field_group`) —
  the only dependency. Composer installs it for you.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Field Group and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group_table -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_table -y
```

Drupal enables Field Group at the same time if it is not already on.

Once enabled, the **Table** format becomes available on any bundle's Manage display
and Manage form display screens. See [How to use it](../index.md#how-to-use-it) to
add your first table group.
