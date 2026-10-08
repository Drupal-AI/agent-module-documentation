# Installation

## Requirements

Watchdog statistics is lightweight and needs only core modules:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`).
- Core's **Database Logging** module (`dblog`) — this is the log storage the
  report aggregates.

Drupal enables both dependencies automatically when you turn on the module. There
are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/watchdog_statistics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/watchdog_statistics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en watchdog_statistics -y
```

Views and Database Logging are pulled in automatically if they aren't already on.

## Verify it worked

Log in as a user who can access site reports, then go to
**Reports → Recent log messages** (`/admin/reports/dblog`). You should see a new
**Log messages statistics** tab beside it. Open it to view the grouped, counted
log report. There is no configuration step — the report is ready the moment the
module is enabled.
