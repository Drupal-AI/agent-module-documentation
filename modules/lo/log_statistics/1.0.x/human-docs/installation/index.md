# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Database Logging** module (`dblog`) enabled — this is the data source
  Log Statistics counts, and it is a hard dependency. Drupal will enable it
  automatically when you turn on Log Statistics if it is not already on.
- A **cron job that runs at least once a day.** The daily counts are collected on
  cron, so without a regular cron run the chart will never gain new data.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/log_statistics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/log_statistics -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en log_statistics -y
```

Enabling it also ensures core's `dblog` is on.

## Backfill historical statistics (optional)

The module ships a Drush command that populates the statistics table from your
existing database‑log entries, so you don't have to wait several days of cron
runs before the chart has a meaningful shape. Run it once after enabling if you
want history in the graph straight away.

## Verify it worked

1. Confirm cron is scheduled to run at least daily (Drupal's built‑in cron, a
   system crontab calling `drush cron`, or your hosting scheduler).
2. Log in as a user with the **Administer content** permission and visit
   **`/log-statistics`**. You should see the line chart. If you have just
   installed the module and not backfilled, the chart fills in over the coming
   days as cron records each day's totals.
