<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

The base module works with sensible defaults — everything on this page is
optional tuning of retention and behavior.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Events Log Track**, or navigate directly to
   `/admin/config/system/events-log-track`.

## Settings, field by field

- **Enable log deletion** *(off by default)* — when on, a cron job automatically
  prunes old log rows. Leave it off to keep every event forever (you are then
  responsible for the table's growth).
- **Timespan limit** *(default 30 days, minimum 1)* — the maximum age, in days, of
  rows to keep. Anything older is deleted on cron when log deletion is enabled.
- **Batch size** *(default 50, minimum 1)* — how many rows the deletion cron job
  removes per batch. Raise it to prune large tables faster, lower it to ease the
  load per cron run.
- **Disable database logs** *(off by default)* — when on, events are not written to
  the database table at all. This is meant to be paired with the **Syslog** or
  **Stdout** submodule so events still go somewhere (useful in containerized
  setups where you ship logs to an external system).
- **Log CLI** *(off by default)* — by default, events triggered from Drush or the
  command line are **not** logged. Turn this on to include CLI/Drush-triggered
  events in the audit trail.
- **Skip patterns** *(empty by default)* — one glob pattern per line. Any event
  whose object reference matches a pattern is skipped, which is handy for filtering
  out noise. Use `*` as the wildcard — for example `system.*`.

Click **Save configuration** to apply.

## Setting values from Drush

You can also configure these keys on the command line:

```bash
drush config:set event_log_track.settings enable_log_deletion true -y
drush config:set event_log_track.settings timespan_limit 7 -y
drush config:set event_log_track.settings skip_patterns 'system.*' -y
```

## Automatic deletion (cron)

When **Enable log deletion** is on, Drupal's cron finds rows older than the
timespan limit and deletes them in chunks of the batch size. Make sure cron runs
regularly for this to take effect.

## A note on uninstalling

Uninstalling the module drops the `event_log_track` table entirely, so export or
archive the log first if you need to keep the history.
