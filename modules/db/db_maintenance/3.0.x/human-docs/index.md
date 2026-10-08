# DB Maintenance — manual setup guide

**DB Maintenance** (`db_maintenance`) is a small utility that periodically runs a
**database optimization query** on the tables you choose during Drupal cron —
`OPTIMIZE TABLE` on MySQL/MariaDB, `VACUUM` on PostgreSQL. Over time, tables that
see a lot of inserts and deletes (caches, `watchdog`, sessions, queues) accumulate
overhead and fragmentation; this module reclaims that space and defragments them on
a schedule, without you having to write a custom cron hook or open a database
client.

From its admin form you pick which tables to optimize and how often. On each cron
run the module checks whether enough time has passed since the last run (anywhere
from "every cron" up to bi-monthly) and, optionally, whether the current time falls
inside a quiet maintenance window you define — and if so, it issues the right
optimization query for each configured table. You can list tables per database, or
flip a single switch to optimize **every** base table. It can also log which tables
it optimized for auditing, and it offers an **Optimize now** link to trigger a
one-off run on demand.

It has **no dependencies** and adds no fields, entities, or plugin types — it's just
a cron-driven housekeeping tool. Everything lives in one configuration object,
`db_maintenance.settings`, and the last-run timestamp is kept in state. A single
permission, *Administer db maintenance*, gates the settings form and the manual run;
because it runs raw optimization SQL and can list all tables, grant it only to
trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — choose tables, set the frequency and
   maintenance window, and run an on-demand optimization.

## Where it lives in the admin menu

The settings form sits under **Configuration → System → DB Maintenance**
(`/admin/config/system/db_maintenance`). The **Optimize now** link on that form
triggers an immediate run, and the manual-run route lives at `/db_maintenance`.

## How to use it

Enable the module, then open the settings form and decide what to optimize and how
often. On busy sites, be aware that MySQL **locks** a table for the duration of its
`OPTIMIZE TABLE`, so use the time-interval window to keep optimization out of peak
hours. After that, ordinary cron runs do the work; use **Optimize now** whenever you
want an immediate pass (for example after purging a large volume of content).
