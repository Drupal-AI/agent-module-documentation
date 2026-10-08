# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Database Logging** module (`dblog`) — this module enhances its *Recent
  Log Messages* report, so `dblog` should be enabled.

There are no other module dependencies, no third‑party Composer or PHP library
requirements, and it adds no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/dblog_time_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dblog_time_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dblog_time_filter -y
```

The time-range filter and live server clock are added to the log report
immediately — there is no configuration step.

## Verify it worked

Open **Reports → Recent log messages** (`/admin/reports/dblog`). You should see a
live server clock above the filter form and a new time-range dropdown among the
exposed filters. Choose a range such as *Last hour* and confirm the list narrows to
that period.
