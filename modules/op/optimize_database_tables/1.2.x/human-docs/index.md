# Optimize Database Tables — manual setup guide

**Optimize Database Tables** (`optimize_database_tables`) lets you run your
database's table‑optimization routine straight from Drupal — `OPTIMIZE TABLE` on
MySQL/MariaDB, `VACUUM` on PostgreSQL. Over time, tables that see a lot of deletes
and updates become fragmented and hold on to space they no longer need;
optimization defragments them and reclaims that space, keeping the database lean.

The module gives you a simple admin form where you choose whether to optimize
**all** tables or just a **selected list**, and then runs the work through Drupal's
**Batch API** so it is resilient to timeouts and shows progress as it goes. When it
finishes, it reports the total size before and after and how much space was
reclaimed. There is also a **Drush command** for running the same operation from the
command line or a scheduled maintenance job.

Because optimization runs directly against the database and can **lock or rebuild
tables while it works**, it can briefly affect availability on large tables. Treat
it as a maintenance operation: restrict its permission to trusted administrators,
take a fresh backup first, and prefer running it during low‑traffic windows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which tables to optimize and
   run the optimization from the UI or Drush.

## Where it lives in the admin menu

Once enabled, the settings and run page sits at **Configuration → System → Optimize
Database Tables** (`/admin/config/system/database_optimize_tables`).
