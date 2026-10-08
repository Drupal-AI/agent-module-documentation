# Installation

## Requirements

Hide Preview Button is a single small module with no dependencies:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/hide_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/hide_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hide_preview -y
```

Nothing is hidden until you list form-name patterns on the settings page — see
the "How to use it" section of the [overview](../index.md).

There are no submodules.
