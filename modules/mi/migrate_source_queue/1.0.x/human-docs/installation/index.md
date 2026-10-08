# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Migrate** module (`migrate`) — the only dependency, enabled
  automatically when you turn on this module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_source_queue -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_source_queue -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_source_queue -y
```

## Submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Cron example** | `migrate_source_queue_cron_example` | Example code showing how to process the queue's items during cron runs (since the source plugin does not do this on its own). Enable it if you want a worked example to base your own cron processing on. |

```bash
drush en migrate_source_queue_cron_example -y
```

## Verify it worked

Create a few queue items in code with `createItem()` (each item being an array),
write a migration that uses `plugin: queue` with the matching `queue_name` (see
the [overview](../index.md#how-to-use-it)), then run:

```bash
drush migrate:status
```

The migration's available row count should reflect the number of items currently
on the queue. Run `drush migrate:import` to process them.
