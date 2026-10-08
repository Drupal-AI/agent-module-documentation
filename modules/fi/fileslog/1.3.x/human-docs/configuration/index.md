# Configuration

Private Files Logging has exactly **one setting** in 1.3.x — a retention limit — and
it lives on Drupal core's own logging‑settings page rather than a dedicated form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Logging and errors**, or navigate directly
   to `/admin/config/development/logging`.

This is core's **Logging and errors** page (the module's `configure` route,
`system.logging_settings`). Private Files Logging adds one field to it.

## Maximum logs

- **Maximum logs** — a required number field (minimum **1**) that sets how many log
  files to keep before cron prunes the oldest. It ships defaulting to **1000**.

Each logged event is one file on disk, so this is effectively "how many recent
events to retain." Raise it if you need a longer history and have the disk space;
lower it to keep the private logs directory small.

### How the limit is enforced

Pruning happens **on cron only**, not at the moment each log is written. Cron lists
every log file newest‑first and deletes everything past the limit. Because of that,
the number of files on disk can briefly exceed **Maximum logs** between cron runs —
that is expected. Make sure cron runs regularly if you rely on this to cap disk
usage.

## Save

Click **Save configuration**. The new limit takes effect on the next cron run.

## Setting it from the command line

The value is stored in the `fileslog.settings` config object, so you can also read
or set it with Drush:

```bash
drush config:get fileslog.settings max_items
drush config:set fileslog.settings max_items 5000
```

## Related: reading and clearing logs

Retention aside, day‑to‑day log handling is done in the UI at
`/admin/reports/fileslog` (filter by channel and severity, or use the **Clear**
form) or from the command line with `drush fileslog:show` and
`drush fileslog:delete` — see the [overview](../index.md#how-to-use-it).
