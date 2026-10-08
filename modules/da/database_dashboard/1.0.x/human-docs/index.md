# Database Dashboard — manual setup guide

**Database Dashboard** (`database_dashboard`) adds an admin report that shows you
where your Drupal database's weight sits — an overview of the largest tables by
size and row count, plus information about the cache tables — so you can do basic
monitoring of database usage and health at a glance. It lives under **Reports** and
is meant for administrators and site operators keeping an eye on how the database is
growing.

It has no other module dependencies and runs on Drupal 9, 10, and 11. There is one
setup step beyond enabling it: to read table sizes the module needs a database
connection to the MySQL/MariaDB `information_schema`, which you add to
`settings.php` — see [Installation](installation/index.md).

The report is correctly protected. It provides its own permission, **`access
database_dashboard`**, and the route is gated by it — it is not public. That said,
the information it shows (table structure, sizes, row counts) is operational and can
be sensitive, so keep the `access database_dashboard` permission restricted to
trusted administrators. The module has no other access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   `information_schema` connection to `settings.php`, enable the module, and set the
   permission.

There is **no configuration form** for this module — the one setup step (the
`information_schema` database connection) is done in `settings.php` and is covered
in Installation.

## Where it lives in the admin menu

Once enabled and configured, the dashboard is at **Reports → Database Dashboard**
(`/admin/reports/database`). Only users with the **`access database_dashboard`**
permission can open it — grant that permission on **People → Permissions** to
trusted administrators only.
