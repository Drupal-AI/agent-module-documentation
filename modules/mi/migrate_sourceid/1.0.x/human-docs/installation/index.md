# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — Drupal enables it automatically as a
  dependency when you turn on this module.
- Completed migrations. The block reads the `migrate_map_*` tables that Migrate
  writes during an import, so it only has anything to show once you have run one
  or more migrations.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_sourceid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_sourceid -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_sourceid -y
```

Enable it after your migrations have run.

## Verify it worked

Place the **Migrate Sourceid** block on **Block Layout**
(`/admin/structure/block`), configure `migrate_sourceid.settings` with your old
site's `source_url` and the migration ids to look up (see the
[main guide](../index.md)), import the config, and clear caches. Then visit a
migrated entity's page — the block should display a link back to the original
source entity.
