# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`), which Drupal enables as a dependency.

There are no third-party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/lazy_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lazy_views -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lazy_views -y
```

That's all. There is no configuration and no permissions to set — once enabled,
Lazy Views' JavaScript is attached to every page and acts on any element carrying
the `data-lv-*` attributes. See the [overview](../index.md) for the attributes and
examples.
