# Configuration

Cleaner is configured on a single settings form, and the choices you make there
decide which housekeeping tasks run and how often. Everything happens through cron
afterwards, so nothing runs until cron does.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Cleaner**, or navigate directly to
   `/admin/config/system/cleaner`. Settings are saved to the `cleaner.settings`
   config object.

## What you configure

The form lets you enable the individual maintenance tasks and set how frequently
each should run. Typically this includes:

- **Cache clearing** — periodically clear cache tables. **Schedule this off-peak
  and infrequently.** Clearing caches forces pages to rebuild, which on a busy site
  produces a burst of extra load; hourly clearing usually costs more than the disk
  space it frees.
- **Watchdog (log) trimming** — remove old log rows to keep the `watchdog` table
  from growing without bound. Set the retention deliberately: these rows are what an
  incident investigation reads, so don't prune more aggressively than your
  operational needs allow.
- **Old session cleanup** — remove stale session records.
- **Database table optimisation** — periodically optimise tables to reclaim space
  and keep queries efficient.

## Save

Click **Save configuration**. From then on the enabled tasks run during cron at the
frequencies you set. If you want to confirm the behaviour, run cron manually
(`drush cron`) and check that the expected tables have been trimmed or cleared.

## A note on retention

Anything here that deletes rows is irreversible. Decide your log and session
retention policy on purpose — long enough to support debugging and incident
review, short enough to keep the tables manageable — rather than accepting the
most aggressive setting by reflex.
