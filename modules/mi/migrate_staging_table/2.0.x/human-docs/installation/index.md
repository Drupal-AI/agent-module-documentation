# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — Drupal enables it automatically as a
  dependency when you turn on this module.

There are no third-party Composer or PHP library requirements.

> This release line is published as an alpha (`2.0.0-alpha1`), the project is
> seeking a co-maintainer, and it is **not covered by Drupal's security advisory
> policy**. That's fine for a controlled migration on your own site, but test it
> against your data and avoid exposing staging tables that hold sensitive content.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_staging_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_staging_table -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_staging_table -y
```

That's all it takes. There is no configuration form — the `staging_table` source
and destination plugins and the `staging_table_lookup` process plugin are now
available to any migration definition.

## Verify it worked

Write a small migration that uses the `staging_table` destination plugin (see the
[main guide](../index.md)) and run it with `drush migrate:import`. The module
creates the staging table for you (with automatic `id` and `created` columns), so
after the run you can inspect that table to confirm your data landed there, then
read it back with the `staging_table` source plugin.
