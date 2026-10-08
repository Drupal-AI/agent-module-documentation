# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No other modules are strictly required — it uses core's logger system.
- To actually see and query the entries, have a logger backend enabled: core
  **Database Logging** (`dblog`) stores them in the `watchdog` table, or
  **Syslog** sends them to the OS. For richer, filterable/structured logs the
  module works well with the contributed **Logger** / **Logger DB** modules.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/request_logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/request_logger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en request_logger -y
```

It works immediately — a log entry is now added for every request to the site.
Head to [Configuration](../configuration/index.md) to choose exactly what is
captured.

## Submodules

Request Logger ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Request Logger Reports** | `request_logger_reports` | Views-based report pages that display the logged requests and responses directly in the admin panel, with filtering by custom fields (and, with the Charts module, charts). It works best alongside the Logger DB module, which stores structured custom fields with each log entry. |

Enable it with:

```bash
drush en request_logger_reports -y
```

## Verify it worked

Browse a few pages on the site, then go to **Reports → Recent log messages**
(`/admin/reports/dblog`, if dblog is enabled) and look for entries on the
`request_logger` channel — for example
`GET /node - query: page=2, response: duration: 0.227 sec, memory: 3.518 MB, page cache: HIT`.
