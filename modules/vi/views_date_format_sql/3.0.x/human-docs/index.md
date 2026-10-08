# Views Date Format SQL — manual setup guide

**Views Date Format SQL** (`views_date_format_sql`) lets a View format a
timestamp date field *inside the SQL query* instead of in PHP when the row is
rendered. That small change unlocks something core Views cannot do on its own:
**grouping rows by a coarse date bucket**. Because the date is formatted in the
database — using its native `DATE_FORMAT` — every timestamp in, say, the same
month collapses to the identical string (`2024-03`), so Views aggregation can
`GROUP BY` it and count how many rows fall in each month.

Core Views formats dates at render time, which means two records from the same
month but different days are still distinct values that can't be aggregated
together. This module moves the formatting into the query, so you can build
"posts per month", "orders per week", or "activity per year" style reports
directly from a timestamp field — no custom SQL and no loading every entity just
to bucket it by date.

There is nothing to install a settings page for and no permissions to grant. The
module works by quietly swapping the default Views handler on any Field-API
`timestamp` field: once enabled, those fields gain an extra **"Use SQL to format
date"** checkbox in their Views configuration. Tick it, turn on aggregation, and
choose a coarse date format such as `Y-m` (month) or `Y` (year). It supports
MySQL, PostgreSQL and SQLite, because the actual formatting is delegated to
Drupal core's per-driver date SQL.

This guide is written for a **human** clicking through the Views UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere of its own — there is no settings page. Everything happens inside the
**Views UI** (`/admin/structure/views`), on the individual date field and
contextual-filter handlers of a View.

## How to use it

The module only affects **Field-API `timestamp` fields** (it deliberately skips
core `created`/`changed` base fields unless they're exposed as timestamp fields,
and it skips file tables). On those fields you don't pick a special handler —
you simply get an extra checkbox.

**To group a View by month, quarter, or year:**

1. Edit your View and add the timestamp field (or the entity's date field) to the
   **Fields** list.
2. In the field's configuration, tick **Use SQL to format date**. Set its
   **Date format** to a coarse pattern — `Y-m` for month, `Y` for year, `Y-m-d`
   for day. (This reuses the field's normal core "Date format" setting, and an
   optional timezone offset, so display stays consistent.)
3. Open the View's **Advanced → Use aggregation** and set it to *Yes*. This is
   the step that makes the grouping actually happen: the SQL-formatted date
   becomes a `GROUP BY` key.
4. Add whatever you're counting (for example an ID field set to *Count* under its
   Aggregation settings), and you'll get one row per time bucket.

**To filter by a date bucket with a contextual filter:**

Add the timestamp field as a **contextual filter (argument)**. It gains the same
**Use SQL to format date** checkbox plus a free-text **Date Format** box. Set the
format to, say, `Y-m`, and then passing `2024-03` as the argument matches every
row in March 2024.
