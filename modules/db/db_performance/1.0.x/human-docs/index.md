# DB Performance — manual setup guide

**DB Performance** (`db_performance`) watches your site's database traffic, spots
the queries that run slowly, and helps you fix them — all from inside Drupal, with
no external profiling service. As people use the site it quietly collects slow SQL
statements, groups near-identical ones together with query "fingerprinting"
(normalising the values so that a thousand variations of the same query count as
one), and builds statistics for each group: how many times it ran, its average
execution time, and its worst-case time. From there it highlights the queries
costing you the most and — the headline feature — suggests database indexes that
would speed them up, which you can optionally create.

The problem it solves is a common one: a page feels slow, but the slowness lives
in how Drupal talks to the database (a Views query, an EntityQuery, a missing
index) rather than in PHP you can easily see. Tools like Devel and Webprofiler
show you queries, but they don't aggregate them over time or tell you which index
would help. DB Performance is deliberately narrow — it focuses on database access
patterns and index tuning — and works standalone with MySQL, MariaDB, or
PostgreSQL.

There is nothing you *must* configure. The module starts collecting the moment you
enable it, and the important thing is to let the site run under normal traffic
first so it has real data to analyse — then read the report. Two permissions gate
access, and you should grant them only to trusted administrators, because the
report exposes query internals and the index actions change your database schema.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module — it works without configuration.
Everything happens on its report page, described below.

## Where it lives in the admin menu

Once enabled, the report sits under **Reports → DB Performance**
(`/admin/reports/db-performance`). This is where you review the collected slow
queries, their statistics, and the suggested indexes.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. **Use your site normally.** This step matters — the module needs real usage
   data to produce meaningful insights, so let it run under typical traffic for a
   while before you draw conclusions.
3. Go to **Reports → DB Performance** (`/admin/reports/db-performance`) and review
   the aggregated slow queries. Cache, session, and other internal-table queries
   are filtered out so you see what actually matters.
4. Look at the suggested indexes for the most impactful queries and, if
   appropriate, create them. Treat index changes like any schema change — test on
   a non-production copy first.

Grant the `access db performance reports` and `manage db performance indexes`
permissions only to trusted administrators.
