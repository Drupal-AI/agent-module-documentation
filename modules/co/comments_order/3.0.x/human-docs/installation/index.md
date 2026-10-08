# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Comment** module (`comment`) enabled — Drupal enables it automatically
  as a dependency when you turn on Comments Order.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/comments_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comments_order -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comments_order -y
```

There are no submodules. Once enabled, the ordering options appear on the edit form
of every comment field — head to [Configuration](../configuration/index.md) to set
the order for a field.
