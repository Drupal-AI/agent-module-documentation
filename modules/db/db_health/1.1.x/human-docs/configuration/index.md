# Configuration

DB Health works as soon as it is enabled — the report is populated by cron and can
be refreshed on demand. This page covers its settings form and the two places you
interact with it: the report and the manual check.

## Open the settings form

1. Log in as a user with permission to administer site configuration (an
   administrator by default).
2. Open the module's settings form (the `db_health.settings` configuration form),
   reachable from the module's entry in the admin configuration area.

The form lets you adjust how DB Health behaves — for example how its periodic
monitoring and logging operate during cron. Set the options to suit how closely you
want to track growth, then click **Save configuration**.

## View the report

The report lives at **Reports → Database Health** (`/admin/reports/db-health`). It
shows:

- the **total database size**,
- the **size of each table**, and
- the **number of rows per table**,

in sortable tables alongside interactive, filterable graphs of how those figures
have changed over time. Sort by size or row count to find the tables worth
investigating.

## Run a check manually

The periodic snapshots are collected by cron, but you can capture one immediately
with the provided Drush command:

```bash
drush db-health:run
```

(Prefix with `ddev` from the host, or run inside `ddev ssh` without the prefix.)
Use it after a big import or a cleanup to see the effect right away rather than
waiting for the next cron run.

## Keep the report private

The report exposes database metadata — table names, sizes, and structure — which is
operational detail you should not reveal publicly. Make sure only trusted
administrators can reach **Reports → Database Health**, and do not open the route to
anonymous or low-trust roles.
