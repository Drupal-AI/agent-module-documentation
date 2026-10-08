# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1+**.
- Core modules **Node**, **Views**, and **System** (all standard on a typical
  site; Drupal enables them as dependencies).
- No third‑party Composer packages or external libraries — and no external
  services, so no API keys or credentials to set up.

## Install with Composer

From the project root:

```bash
composer require drupal/content_telemetry -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_telemetry -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module and run updates

```bash
drush en content_telemetry -y
drush updb -y
drush cr
```

The module creates three database tables (raw hourly samples, hourly aggregates,
and daily aggregates), so `drush updb` is important — it ensures the schema is in
place. The raw table is insert‑only and all reporting reads from the aggregate
tables, so day‑to‑day monitoring adds no runtime aggregation work.

## How data collection works

- Aggregation runs on **Drupal cron** (an hourly rollup and a daily rollup), so
  make sure cron runs regularly for the reports to stay current.
- Raw samples are retained for **14 days**; the aggregates persist.
- Collection is **sampled**. In production, leave the default low sampling rate
  to keep overhead minimal; for local testing you can raise it — see
  [Configuration](../configuration/index.md).

## Verify it worked

Visit **Reports → Content Telemetry** (`/admin/reports/content-telemetry`) as a
user with the **view content telemetry** permission. After a little traffic and
at least one cron run, you should see a site‑wide health score and per‑entity
badges begin to populate. If the dashboard is empty at first, generate a few
page views and run cron (`drush cron`) to trigger the rollups.
