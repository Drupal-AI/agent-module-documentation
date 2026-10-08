# Installation

## Requirements

Views Exclude Previous is a small, core-only module:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (used for the contextual-filter default). No other
  dependencies and no third-party libraries.

> **Upgrading from 2.x?** Version 3.x is a complete rewrite with **no upgrade
> path** from the 2.x branch. Treat it as a fresh setup and re-wire your views.

## Install with Composer

From the project root:

```bash
composer require drupal/views_exclude_previous -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/views_exclude_previous -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_exclude_previous -y
```

Nothing changes until you wire the **Previously rendered entities** default into a
view's contextual filter — see the "How to use it" section of the
[overview](../index.md).

There are no submodules and nothing to configure globally.
