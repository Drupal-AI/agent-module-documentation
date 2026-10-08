# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Inline Entity Form** module (`drupal/inline_entity_form`,
  `^1.0 || ^2.0 || ^3.0`) — this is a hard dependency and provides the base IEF
  widget this module extends. Composer pulls it in automatically.

There are no other third-party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ief_table_view_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Inline Entity
Form and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ief_table_view_mode -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with Inline Entity Form (Drush will enable the dependency
automatically):

```bash
drush en ief_table_view_mode -y
```

There is no configuration form to visit. Once enabled, the **Inline entity form -
Complex - Table View Mode** widget becomes available on entity-reference fields.
See the [overview](../index.md) for the two-step setup.
