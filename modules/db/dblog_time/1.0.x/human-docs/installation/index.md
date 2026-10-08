# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Database Logging** module (`dblog`) — this is the log the module
  enhances, so it should be enabled.

There are no other module dependencies, no third‑party Composer or PHP library
requirements, and the module adds no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/dblog_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dblog_time -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dblog_time -y
```

Enabling the module adds an index on the log timestamp and makes the time-based
deletion option available on the core logging settings page.

## Set it up

The one configuration step is on the core **Configuration → Development → Logging
and errors** page (`/admin/config/development/logging`): choose **Timespan**
instead of **Row limit** and enter a value such as `-7 days`. See
["How to use it"](../index.md#how-to-use-it) for the details.

## Verify it worked

Open **Reports → Recent log messages** (`/admin/reports/dblog`) and check that the
timestamps show the finer precision. Then visit the logging settings page and
confirm the **Timespan** option is available.
