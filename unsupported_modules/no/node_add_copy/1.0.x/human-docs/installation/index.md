# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No dependencies beyond Drupal core, and no third-party Composer or PHP
  libraries.

> **Before you install:** this module is **Unsupported / obsolete**. Its
> maintainer recommends
> [**Quick Node Clone**](https://www.drupal.org/project/quick_node_clone)
> instead. Consider that alternative for any new site.

## Install with Composer

From the project root:

```bash
composer require drupal/node_add_copy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/node_add_copy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_add_copy -y
```

## Grant the permission

The module provides its own permission for the copy flow. Grant it to the
appropriate roles at **People → Permissions** (`/admin/people/permissions`).

## Verify it worked

As a user with the copy permission, open an existing node and use the copy action
the module provides. You should land on a **Node add** form of the same content
type, pre-filled with the source node's values, before anything is saved.
