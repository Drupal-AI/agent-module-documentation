# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No contributed‑module dependencies and no third‑party libraries — it uses only
  core.
- Your **database user must have access to `information_schema`** (on MySQL/MariaDB)
  so the module can read table sizes and row counts.
- **Cron must run regularly.** Node Health collects table‑size and row‑count data
  during cron runs; without cron, the historical charts will not populate.

The module creates and uses two tables of its own, `node_health_sizes` and
`node_health_table_names`, to store historical data.

## Install with Composer

From the project root:

```bash
composer require drupal/node_health -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_health -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_health -y
```

## Verify it worked

Log in as an administrator and open **Reports → Node Health**
(`/admin/reports/node-health`). If the report loads, the module is active. The
table‑size **charts** need at least one cron run to begin showing data — run cron
once (`drush cron`) if you want to populate them immediately. Next, see
[Configuration](../configuration/index.md) for the reports, maintenance tools, and
permissions.
