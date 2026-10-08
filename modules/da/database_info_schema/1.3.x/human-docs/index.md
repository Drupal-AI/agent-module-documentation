# Database Info — manual setup guide

**Database Info** (`database_info_schema`) is a schema and metadata explorer for
developers and database administrators. It gives you a real‑time look at the shape
and size of your database: it lists every table, drills into each table to show its
columns (name, data type, nullability, key constraints) and indexes, and reports
storage metrics — total database size, per‑table size, and per‑index size. It is
handy for database auditing, onboarding new developers who need structural context,
and performance/capacity planning. It runs on Drupal 10 and 11 with no other module
dependencies, and exposes its features through both a Drush command and a set of
admin pages.

> ## Before you enable it — who can reach the pages
>
> The pages **`/admin/database/info`** and
> **`/admin/database/table/{tablename}`** are gated by the core **`access content`**
> permission (the module defines no permission of its own). `access content` is a
> broadly granted permission, so as shipped these pages are reachable by a wide set
> of roles rather than administrators only.
>
> Because the pages reveal structural and storage details about your database, treat
> that information as operational and decide who should see it in your environment.
> On shared, staging, or production sites, place the routes behind an appropriate
> administrative permission (for example with a small custom module or a route
> subscriber) so that only trusted users reach them. On an isolated local
> development site this is usually not a concern.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration form** for this module.

## Where it lives in the admin menu

A menu link "Database Information" appears under Administration » Configuration »
System. The explorer's pages are at **`/admin/database/info`** (the table inventory)
and **`/admin/database/table/{tablename}`** (per‑table columns, indexes, and row
count). A Drush command exposes the same information from the command line.
