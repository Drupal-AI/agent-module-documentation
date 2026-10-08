# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** (`block`) and **Node** (`node`) modules, both part of a
  standard Drupal install and enabled automatically as dependencies.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/quick_node_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/quick_node_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quick_node_block -y
```

The module ships no submodules and has no global settings. Once enabled, place a
**Quick Node Block** in a region to start showing a node — see
[Configuration](../configuration/index.md).
