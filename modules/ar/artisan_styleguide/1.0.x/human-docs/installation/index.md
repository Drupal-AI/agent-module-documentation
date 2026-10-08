# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Serialization** module (`serialization`), which the module uses to
  serialise component data for display. It is Drupal core and is enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/artisan_styleguide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/artisan_styleguide -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en artisan_styleguide -y
```

Enabling it pulls in the core Serialization module if it is not already on. The
style‑guide page becomes available for your theme — see
[How to use it](../index.md#how-to-use-it). There is no settings form to
configure.

This module has no submodules.
