# Configuration

DB Cleanups needs a little configuration to be useful: you tell it how often to
trim the watchdog table and how often to clear the cache tables, and whether to
optimize the tables afterwards. Everything lives on a single settings form.

## Open the settings form

1. Log in as a user with permission to administer site configuration (an
   administrator by default).
2. Go to **Configuration → Development → Database Cleanup Settings**
   (under `/admin/config/development`).

## The settings, field by field

- **Watchdog Cleanup Interval (hours)** — how frequently the module trims the
  watchdog (dblog) table during cron. A smaller number cleans more often and keeps
  the log table small; a larger number keeps more log history around. Remember that
  trimming discards log entries permanently, so pick an interval that leaves you
  enough history for troubleshooting.
- **Cache Tables Cleanup Interval (hours)** — how frequently the module clears the
  `cache_*` tables during cron. This controls the growth of cached data on disk.
- **Optimize tables after cleanup** — a toggle. When enabled, the module runs
  `OPTIMIZE TABLE` after a cleanup to reclaim freed space and can improve
  performance. This is more intensive than a plain delete, so on large tables you
  may prefer to run it during quiet periods.

## Save

Click **Save configuration**. From then on, the cleanups run automatically during
Drupal cron at the intervals you set — so make sure cron is scheduled to run
regularly.

## Run a cleanup now

The form also provides **manual controls** to clear the cache tables and watchdog
entries immediately, without waiting for the next scheduled cron run. Use the
**Run Cleanup Now** control when you need to reclaim space straight away or want to
confirm the cleanup behaves as expected.

> **Reminder:** these actions are destructive. Clearing watchdog removes log
> history, and clearing cache forces Drupal to rebuild cached data. Both are safe
> in the sense that they do not touch your content, but the discarded logs cannot
> be recovered.
