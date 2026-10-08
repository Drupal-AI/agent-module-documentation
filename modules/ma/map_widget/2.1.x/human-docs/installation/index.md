# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
  The `10.3`-plus requirement is because the module uses modern PHP attributes for
  its form element and widget plugins.
- No module dependencies, and no third-party Composer or PHP library requirements.
- A field whose items are stored as a **map** (associative array) to attach the
  widget to.

## Install with Composer

From the project root:

```bash
composer require drupal/map_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/map_widget -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en map_widget -y
```

That is all the setup there is. There is no configuration page — to use the widget,
select it on a map field's **Manage form display** screen, as described in the
"How to use it" section of the [overview](../index.md).

There are no submodules.
