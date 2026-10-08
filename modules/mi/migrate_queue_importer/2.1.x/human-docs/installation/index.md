# Installation

## Requirements

Migration queue importer builds on the Migrate ecosystem, so you need:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Migrate** module.
- **Migrate Tools** (`drupal/migrate_tools` `>=5.0`) — provides the import
  execution the queue worker uses.
- **Migrate Plus** (`drupal/migrate_plus` `>=5.0`) — the common source/plugin
  layer for configured migrations.

Composer pulls both contrib dependencies in for you. You'll also need at least one
actual migration (a migration plugin id) for a schedule to reference.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_queue_importer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in **Migrate Tools**
and **Migrate Plus** and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_queue_importer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_queue_importer -y
```

This enables the module along with **Migrate Tools** and **Migrate Plus** (and core
Migrate) if they aren't already on.

## Grant the permission (optional)

Only users with the **Administer cron migrations** permission can reach the admin
screen and manage schedules. Grant it to your site operators at **People →
Permissions** (`/admin/people/permissions`).

## A working cron is required

Because this module does its work during cron, make sure cron actually runs on your
site — ideally via a real system cron job or `drush cron`, not just the occasional
manual trigger. Head to [Configuration](../configuration/index.md) to create your
first scheduled migration.
