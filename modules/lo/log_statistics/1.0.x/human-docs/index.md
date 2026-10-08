# Log Statistics — manual setup guide

**Log Statistics** (`log_statistics`) turns Drupal's raw database log into a
picture. Core's Database Logging (`dblog`) module records every watchdog message
individually, but it gives you no sense of *trend* — whether errors are climbing,
whether a deployment caused a spike, whether one noisy module is flooding the log
with notices. Log Statistics fills that gap by keeping its own small table of
per‑day counts for each RFC 5424 severity (emergency, alert, critical, error,
warning, notice, info, debug) and drawing them as a line chart.

It works quietly in the background. On each cron run the module tallies the
previous day's log messages by severity and stores the totals in its own
`log_statistics` table — so it keeps *aggregate counts*, not copies of the log
text. You then view the trend as a Google‑Charts line graph (the last several
days) on a dedicated page. A Drush command is included to backfill historical
statistics if you want a chart with some history in it from day one.

Because the counts accumulate on cron, this module needs a working cron job that
runs **at least once a day** — without cron, no new daily totals are recorded.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   (alongside core's `dblog`), and make sure cron runs daily.

This module has **no settings form** — there is nothing to configure. Its one
page is the chart itself, described below.

## Where it lives in the admin menu

Log Statistics adds no item to the admin configuration menu. Its chart lives at
the path **`/log-statistics`**, which renders the aggregated line graph. The page
is gated by the core **Administer content** permission, so log in as a user who
holds it (an administrator by default) and visit that path directly.

## How to use it

1. Enable the module and let it run — the counts are collected automatically on
   each cron run. Because yesterday's totals are what get stored on today's run,
   the chart fills in over the following days.
2. To see history immediately rather than waiting, run the module's Drush
   backfill command to populate past statistics from your existing `dblog`
   entries.
3. Visit `/log-statistics` to view the line chart. Each severity is a line, so
   you can spot a rising trend in errors or warnings, or a sudden spike in
   critical/emergency messages, at a glance. Recent daily statistics are paged
   ten rows at a time, newest first.

Think of it as a lightweight, time‑series companion to core's `dblog` report —
`dblog` tells you *what* each message was; Log Statistics tells you *how the
volume is moving over time*.
