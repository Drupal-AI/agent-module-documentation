# Watchdog statistics — manual setup guide

**Watchdog statistics** (`watchdog_statistics`) adds a "Log messages statistics"
report on top of Drupal's core Database Logging (dblog / watchdog) system.
Instead of scrolling through thousands of near-identical log rows, it groups the
log by *identical message* and shows how many times each one occurred, plus the
id and timestamp of the most recent occurrence. It's the fastest way to spot the
noisiest error on your site and triage what to fix first.

Under the hood the module is a Views-driven enhancement of core dblog. It exposes
three new pieces of Views data on the `watchdog` table — a **Message count**
field/sort, a **Latest WID** field (linking to the newest individual event), and
a **Latest timestamp** field/sort — and ships a ready-made View that uses them.
That View becomes a new tab at **Reports → Recent log messages → Log messages
statistics**, sorted by message count so the most frequent messages float to the
top. Because the aggregation is just Views data, you can also build your own
watchdog-based View and drop the "Message count" column into it.

The module has no settings form of its own, adds no permissions, and provides no
Drush commands. It reuses core dblog's own access — anyone who can see the site
reports (the **Access site reports** permission) can see the statistics tab. It
depends on core's **Views** and **Database Logging** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with its Views/dblog dependencies).

## Where it lives in the admin menu

There is no configuration page. Once enabled, the report appears at
**Reports → Recent log messages → Log messages statistics**
(`/admin/reports/dblog/statistics`), sitting as a tab right next to core's
"Recent log messages" report.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Reports → Recent log messages** (`/admin/reports/dblog`) and click the
   new **Log messages statistics** tab.
3. You'll see one row per distinct log message, with a **Message count** column
   showing how often each occurred and a **Latest timestamp** column. The list is
   sorted by count (noisiest first), then by most recent. Click the exposed sort
   controls to reorder, or use the exposed date filters to scope the report to a
   time range.
4. Each row's **Latest WID** links straight to the most recent individual
   occurrence of that message in the normal dblog event view, so you can drill
   into the full details.

To reuse the aggregation elsewhere, build any View on the *watchdog* base table
and add the **Message count** field — that single field triggers the grouping —
then sort by it descending. Add **Latest WID** and **Latest timestamp** if you
want the "most recent occurrence" columns too.

Want to change the shipped report's columns, sort, or filters? There is no
settings object — edit the View directly, e.g.
`drush config:edit views.view.watchdog_statistics`.
