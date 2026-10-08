# Installation

## Requirements

Entity Reference Drag & Drop has no third‑party dependencies:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's entity reference and field system, plus `core/sortable` (both part of
  Drupal core — nothing extra to install).

## Install with Composer

From the project root:

```bash
composer require drupal/entityreference_dragdrop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entityreference_dragdrop -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entityreference_dragdrop -y
```

Then go to **Manage form display** for the content type (or other entity) that has
the entity reference field, set the field's widget to **Drag&Drop**, and configure
it — see [How to use it](../index.md#how-to-use-it). There is no separate
configuration page and no submodules.
