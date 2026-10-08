# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Migrate** module (`migrate`) enabled — Drupal enables it automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements. You'll typically also
use the contrib migration tooling (Migrate Plus, Migrate Tools) to run migrations, but
those aren't hard dependencies of this module.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_conditions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_conditions -y
```

That's all there is to it — there's no configuration form and no permissions. Once
enabled, the condition and process plugins are available for use in your migration
YAML; see the [main guide](../index.md#how-to-use-it) for examples.

This module ships no submodules.
