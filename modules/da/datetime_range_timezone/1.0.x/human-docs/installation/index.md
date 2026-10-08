# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Datetime Range** module (`datetime_range`) enabled — the module
  extends it, and Drupal enables it automatically as a dependency. (Datetime
  Range in turn depends on core's Datetime module.)
- Optional: the contrib **Token** module, if you want the timezone-aware
  `start_date` / `end_date` tokens.

There are no third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/datetime_range_timezone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/datetime_range_timezone -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datetime_range_timezone -y
```

There is no settings form to visit. Add a **Datetime Range Timezone** field to a
content type's **Manage fields** tab and configure the widget and formatter — see
[How to use it](../index.md#how-to-use-it).

This module ships no submodules.
