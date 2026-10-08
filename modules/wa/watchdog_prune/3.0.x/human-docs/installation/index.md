# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Database Logging** module (`dblog`) enabled — that is the module that
  populates the `watchdog` table Watchdog Prune trims. If dblog is not enabled,
  there is nothing to prune.
- A working **cron** — pruning only runs during cron.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/watchdog_prune -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/watchdog_prune -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en watchdog_prune -y
```

Enabling the module does not prune anything yet — you need to set a retention
policy and adjust one core setting. Continue to
[Configuration](../configuration/index.md).
