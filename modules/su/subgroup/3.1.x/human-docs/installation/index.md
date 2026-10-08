# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **The [Group](https://www.drupal.org/project/group) module, version 3.0 or
  newer** (`drupal/group:^3.0`). Subgroup builds directly on Group 3.x — Composer
  installs it for you if it isn't already present. (Note: Subgroup 3.1.x targets
  Group *3.x*; it is not compatible with the older Group 1.x/2.x lines.)

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/subgroup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update Group and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/subgroup -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en subgroup -y
```

## Right after enabling

Grant the restricted **Administer subgroup** permission to your administrator role
at *People → Permissions* so you can reach the settings form at *Group → Subgroup*.

Before building trees, make sure you have at least **two Group types** defined
(Subgroup needs a parent type and a child type to create a tree). Then continue to
[Configuration](../configuration/index.md).

This module has no submodules.
