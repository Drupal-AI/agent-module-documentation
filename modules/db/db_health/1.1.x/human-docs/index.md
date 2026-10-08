# DB Health — manual setup guide

**DB Health** (`db_health`) gives site administrators a clear picture of their
Drupal database — the total database size, the size of each individual table, and
the number of rows per table — and tracks how those figures change over time so you
can spot tables that are growing unexpectedly before they cause performance
problems.

The data is shown on an admin report with sortable tables and interactive,
filterable graphs. A cron task runs periodically to collect and log database and
table statistics, building up a historical record of growth, and you can also
trigger a check manually from Drush. Typical uses are tracking database growth
trends, detecting bloated tables that hint at a bug or a logging issue, and
supporting data-driven decisions about optimization, archiving, and scaling.

Because the report reads database metadata — table names, sizes, structure — it is
operational detail that should stay behind the admin interface. Keep the report
gated to administrators and do not expose it publicly.

The module works as soon as it is enabled: the report is available immediately and
the cron logging starts running on your site's normal cron schedule. It also
provides a small settings form for tuning its behaviour.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, plus where the
   report lives and how to run a check manually.

## Where it lives in the admin menu

- The report is at **Reports → Database Health**
  (`/admin/reports/db-health`).
- The settings live at the `db_health.settings` configuration form (linked from the
  module's admin section). See [Configuration](configuration/index.md).

## How to use it

Once enabled, ensure your site's **cron** is running so the module keeps logging
database statistics over time. To collect a fresh snapshot immediately, run the
provided Drush command:

```bash
drush db-health:run
```

(Prefix with `ddev` from your host — `ddev drush db-health:run` — or run it inside
`ddev ssh` without the prefix.) Then open **Reports → Database Health** to review
current table sizes and row counts and explore the historical growth graphs.
