# Installation

## Requirements

- **Drupal 11** (the 3.x branch: `core_version_requirement: ^11`).
- Core's **Migrate** module (`migrate`).
- **Migrate Plus** (`migrate_plus`) — a required dependency; several plugins build
  on its data‑parser / source infrastructure.
- For the Commerce shipment‑item plugin, a working **Drupal Commerce** install.

There are no third‑party Composer libraries beyond the modules above.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_dc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus and
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_dc -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_dc -y
```

Drush will enable core Migrate and Migrate Plus as dependencies if they aren't
already on.

## Verify it worked

There is no admin page. Reference one of the module's plugins (for example
`migrate_dc_json` as a source, or `migrate_dc_str_to_time` in a process step —
see [the module overview](../index.md#how-to-use-it)) in a migration and run
`drush migrate:import <your_migration>`. A successful run confirms the plugins are
registered.
