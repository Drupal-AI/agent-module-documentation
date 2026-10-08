# DB Cleanups — manual setup guide

**DB Cleanups** (`db_cleanups`) automatically cleans Drupal's cache tables and the
watchdog (dblog) table at configurable intervals, to keep database growth under
control. It is aimed at sites on shared or resource-restricted hosting where the
`cache_*` tables and the `watchdog` log table can balloon and eat storage.

Once configured, it runs during Drupal cron: it trims the watchdog table on one
schedule and clears the cache tables on another, each interval set in hours. It can
optionally run `OPTIMIZE TABLE` after a cleanup to reclaim disk space, and it adds
manual "run now" controls so you can clear cache or watchdog immediately from the
settings form. It is intentionally lightweight — no external libraries, just
Drupal's core cron and database-logging systems.

Two cautions are worth keeping in mind. First, the operations are **destructive**:
trimming the watchdog table discards log history, so if you rely on dblog for
incident investigation or auditing, be deliberate about how aggressively you clean
it. Second, the automatic cleanups **depend on cron actually running** on a
sensible schedule — if cron is not firing, the tables will not be cleaned.

The module needs configuration to be useful — you set the intervals and options on
its settings form after enabling it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the cleanup intervals, the
   optimize-tables option, and use the manual "run now" controls.

## Where it lives in the admin menu

The settings form sits at **Administration → Configuration → Development →
Database Cleanup Settings** (`/admin/config/development/…`). See
[Configuration](configuration/index.md).
