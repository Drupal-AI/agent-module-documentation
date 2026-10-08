# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **jQuery** — the only thing it relies on, and it is part of core.

There are no other module dependencies and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/better_parent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_parent -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_parent -y
```

## That's the whole setup

There is nothing to configure. Open any node add/edit form, expand **Menu
settings**, and you'll find the new **(browse)** toggle next to the *Parent item*
dropdown. See the [overview](../index.md#how-to-use-it) for how to use it.
