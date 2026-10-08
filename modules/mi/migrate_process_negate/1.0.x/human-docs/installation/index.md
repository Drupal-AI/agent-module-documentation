# Installation

## Requirements

Migrate Process Negate is deliberately minimal. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Migrate** module (`migrate`) enabled — this is the only dependency,
  and Drupal enables it automatically as a dependency when you turn on this
  module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_process_negate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_process_negate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_process_negate -y
```

## Verify it worked

The plugin registers as `negate` and is available to any migration immediately.
Add it to a migration's `process` pipeline (see the example in the
[overview](../index.md#how-to-use-it)) and run `drush migrate:import` — the
mapped value should come out inverted.
