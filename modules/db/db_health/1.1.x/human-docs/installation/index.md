# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer packages
  or libraries.
- A working **cron** schedule, so the module can periodically log database
  statistics and build up its historical record.

## Install with Composer

From the project root:

```bash
composer require drupal/db_health -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/db_health -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en db_health -y
```

## Verify it worked

Log in as an administrator and go to **Reports → Database Health**
(`/admin/reports/db-health`). You should see the current database and per-table
sizes with row counts. To populate the report immediately rather than waiting for
cron, run:

```bash
drush db-health:run
```

Then reload the report to confirm the data appears, and continue to
[Configuration](../configuration/index.md) to tune the module's behaviour.
