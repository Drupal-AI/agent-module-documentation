# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no additional Composer or PHP library requirements. The module works on
core's node system with no other dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/blank_node_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/blank_node_title -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blank_node_title -y
```

After enabling, choose which content types get optional titles on the settings form
at `/admin/config/content/blank-node-title`. See
[How to use it](../index.md#how-to-use-it).
