# Dblog Time — manual setup guide

**Dblog Time** (`dblog_time`) improves how timestamps are shown on Drupal's
database log and gives you time-based control over how long log entries are kept.
Core's *Recent log messages* report (`/admin/reports/dblog`) formats times with the
site's *medium* date format, which usually means **minute precision**. That is fine
for casual browsing but useless for the thing the log is most often opened for:
working out the **order of events**. When four entries share the same minute, the
sequence — which query ran before which error, whether cron preceded the failure —
is exactly the information you need, and minute precision throws it away. Higher
precision matters even more when you're correlating Drupal's log against a web
server access log or an APM trace, where a one-second ambiguity is enough to match
the wrong request.

The module does two things. First, it adds finer time-display options so you can
read log timestamps at the precision debugging actually needs. Second, it lets you
**expire log entries by age** instead of by row count: it adds an index on the log
timestamp (so date filtering on the report performs well) and offers a cron option
to delete messages older than a chosen timespan — even per module, so you could
keep login logs for a month but cron logs for just a week.

It has no dependencies and adds no permissions of its own — access to the log
remains core's *access site reports* permission. Note the trade-off called out by
the maintainer: keeping logs for a fixed period rather than a fixed count can let
the log table grow large under heavy traffic, so choose your timespan with that in
mind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no dedicated settings form** for this module — it extends Drupal's
existing *Logging and errors* settings page. The one setup step is described below.

## Where it lives in the admin menu

Its time-based deletion option is added to the core **Configuration → Development →
Logging and errors** page (`/admin/config/development/logging`). The improved
timestamps appear on **Reports → Recent log messages** (`/admin/reports/dblog`).

## How to use it

To switch from count-based to age-based log pruning:

1. Go to **Configuration → Development → Logging and errors**
   (`/admin/config/development/logging`).
2. Choose **Timespan** instead of the default **Row limit**.
3. Enter a timespan such as `-7 days` to delete messages older than seven days.
   The field accepts anything PHP's `strtotime()` understands, and you can control
   the retention period per module.

Cron then deletes entries older than your chosen timespan on each run.

## A note on timezones and long-term logging

Two things worth keeping in mind. Core's dblog renders times in the **viewing
user's** timezone, so a developer in one country and a server in another can see
timestamps that don't obviously line up with `/var/log` — know whether the
displayed time is local or UTC before you correlate anything. And regardless of
formatting, dblog is a poor long-term logging destination: it writes to the
database on the request path and is capped in size. For serious diagnosis, ship
logs via `syslog` or a dedicated log service and keep dblog for convenience.
