# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No external libraries or APIs, and **no dependency on core logging modules**
  (dblog, syslog) — that independence is the point of this module.

This is an **alpha** release (`1.0.0-alpha1`) — test before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/cevlogger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cevlogger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cevlogger -y
```

## Run database updates

After enabling, run the database updates so the log table (`cevlogger_logs`) is
created:

```bash
drush updb -y
```

Without this step there is nowhere to store log entries.

## Verify it worked

Visit **Reports → Custom Event Logger** (`/admin/reports/cevlogger`) — the report
page should load (empty at first, since nothing is logged automatically). To
confirm logging works end to end, send a test entry from the service, for example:

```bash
drush php:eval "\Drupal::service('cevlogger.logger')->log('test', 'info', 'Hello from cevlogger');"
```

Reload the report and the entry should appear. See
[How to use it](../index.md#how-to-use-it) in the main guide for calling the
service from your own code.
