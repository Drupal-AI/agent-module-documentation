# DB Optimize — manual setup guide

**DB Optimize** (`dboptimize`) is a lightweight maintenance utility that runs SQL
`OPTIMIZE TABLE` operations on your Drupal database from inside the admin UI, on a
schedule via cron, or from the command line with Drush. Over time — especially on
busy sites where tables like `cache_*`, `watchdog`, and `sessions` churn constantly
— database tables become fragmented and hold on to space freed by deleted rows.
Optimizing them reclaims that space and can improve performance, and this module
lets you do it without ever touching the database directly.

You can point it at specific tables or leave the list blank to optimize every
table. It logs each optimization action to Drupal's log (`dblog`) with clear error
handling, so you can see what ran and whether it succeeded. Three ways to run it:
manually from the settings form, automatically during cron, and via a Drush command
for quick CLI use or scripting.

The module works on **MySQL and MariaDB**; PostgreSQL is not yet supported. It's a
database-maintenance tool for administrators, with no content-access role. One
important caution: **`OPTIMIZE TABLE` locks the tables it works on** for the
duration of the operation, which can briefly affect a live site — so run it during
low-traffic windows and restrict access to trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — choose which tables to optimize, run
   it manually, and set it up for cron.

## Where it lives in the admin menu

Its settings and manual-run form sit under **Configuration → System → DB Optimize**
(`/admin/config/system/dboptimize`). Optimization results are written to **Reports
→ Recent log messages** (`/admin/reports/dblog`).
