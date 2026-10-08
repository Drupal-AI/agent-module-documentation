# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core (it uses core cron and core Database
  Logging), and no third‑party Composer packages or libraries.
- A working **cron** schedule — the automatic cleanups run during Drupal cron.

## Install with Composer

From the project root:

```bash
composer require drupal/db_cleanups -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/db_cleanups -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en db_cleanups -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Development → Database
Cleanup Settings**. You should see the settings form with fields for the watchdog
and cache cleanup intervals and the optimize-tables option. From there, continue to
[Configuration](../configuration/index.md) to set your schedule — and confirm your
site's cron is running so the cleanups actually fire.
