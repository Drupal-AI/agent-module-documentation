# Installation

## Requirements

Entity Field Condition is lightweight. It needs:

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement:
  ^8.7.7 || ^9.0 || ^10 || ^11`).
- Core's **Node** module (`node`) enabled — the only dependency, since the
  condition works against nodes. Drupal enables it automatically if it isn't
  already on.

There are no third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_field_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_field_condition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_field_condition -y
```

There is nothing to configure globally. The **node field** condition becomes
available immediately in every block's visibility settings — see
[How to use it](../index.md#how-to-use-it).

This module ships no submodules.
