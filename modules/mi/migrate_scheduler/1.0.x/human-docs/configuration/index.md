# Configuration

Migrate Scheduler has **no admin form**. You configure it entirely by adding a
configuration array to your site's `settings.php` (or `settings.local.php` if you want a
per-environment schedule). This section explains that array.

## The schedule array

Add a `$config['migrate_scheduler']['migrations']` array that maps each migration's id to
its schedule. For example:

```php
$config['migrate_scheduler']['migrations'] = [
  'migration_1' => [
    'time'   => 3600,   // run at most once an hour
    'update' => TRUE,   // re-process rows that were already imported
  ],
  'migration_2' => [
    'time'   => 28800,  // every 8 hours
  ],
  'migration_3' => [
    'time'   => 60,     // every minute (bounded by how often cron runs)
    'sync'   => TRUE,   // remove destination items that are gone from the source
  ],
];
```

The keys of the array are the **migration ids** — the same names you see in `drush
migrate:status`. A migration id that doesn't exist is simply skipped, so a typo won't cause
an error.

## Per-migration options

Each migration entry supports these keys:

| Key | Type | What it does |
|-----|------|--------------|
| **`time`** | integer (seconds) | The minimum interval between runs. The module records the next run time in Drupal's state as `"{id}_next_execution"`, and fires the migration on the first cron run after that time passes. This is the only required key. |
| **`update`** | boolean (optional) | When `TRUE`, applies Migrate's `--update` behavior — rows that were already migrated are re-processed, so changes in the source are picked up. |
| **`sync`** | boolean (optional) | When `TRUE`, applies Migrate's `--sync` behavior — items that have disappeared from the source are removed from the destination. |

For reference, those three example entries are equivalent to running `drush mim
migration_1 --update`, `drush mim migration_2`, and `drush mim migration_3 --sync` on the
respective schedules.

## How the timing really works

The actual cadence of a migration is `max(time, cron interval)`. The module only gets a
chance to run migrations when cron runs, so:

- If cron runs every 3 hours but a migration is set to `time => 3600` (1 hour), it will
  effectively run every 3 hours, not every hour.
- For short intervals (say, every minute), you must run cron at least that often — typically
  with an external `drush cron` scheduled in the server's crontab, rather than Drupal's
  built-in automated cron.

Also keep in mind that a scheduled migration runs *inside* the cron request. Schedule heavy,
long-running migrations with your cron timeout in mind so they don't get cut off partway.

## Per-environment schedules

Because the configuration is plain PHP in `settings.php`, you can put different schedules in
different environments. A common pattern is to keep production schedules in `settings.php`
and override them (for example with faster intervals) in `settings.local.php` on staging or
development sites.
