# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **No mandatory dependencies** — Logger DB works with core's Drupal logger out of
  the box.

For full control over which custom fields are logged, install an extended logger
alongside it — **Logger** (`drupal/logger`) or **Monolog**. Logger DB is already
integrated with both and will automatically extend them once they are present.
Optional companions worth knowing about are **Request Logger** (per‑request
performance metrics and a unique request ID for filtering) and **Events Log
Track** (logs specific user and entity actions).

## Install with Composer

From the project root:

```bash
composer require drupal/logger_db -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/logger_db -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en logger_db -y
```

If you also want extended custom fields, enable Logger (or Monolog) as well:

```bash
drush en logger -y
```

## Verify it worked

Use the site for a moment so some log entries are generated, then open the Logger
DB report page in the admin panel (see [Configuration](../configuration/index.md)).
You should see stored entries with their timestamps. If you enabled Logger or
Monolog too, their custom metadata fields will be available to add as columns and
filters.
