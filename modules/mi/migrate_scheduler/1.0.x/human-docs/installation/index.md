# Installation

## Requirements

Migrate Scheduler is a very small add-on for the migration system. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`), enabled.
- Working cron. The module does its scheduling from `hook_cron()`, so cron must run at least
  as often as your shortest desired interval — an external `drush cron` on a system crontab
  is recommended for anything finer-grained than a few minutes.

**Migrate Plus** is optional but supported: if it's present, the module keeps its "last
imported" timestamp up to date for scheduled runs. There are no third-party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_scheduler -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_scheduler -y
```

Enabling the module has no visible effect until you add a schedule to `settings.php` — there
is no admin form. See [Configuration](../configuration/index.md) for the schedule format.

There are no submodules.
