<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure migrate_scheduler

There is **no admin UI and no `config/install`**. Scheduling is defined by a config override
placed in `settings.php` / `settings.local.php`:

```php
$config['migrate_scheduler']['migrations'] = [
  'migration_1' => [
    'time'   => 3600,   // seconds between runs (here: hourly)
    'update' => TRUE,   // apply Migrate's --update behaviour (re-process existing rows)
  ],
  'migration_2' => [
    'time'   => 28800,  // every 8 hours
  ],
  'migration_3' => [
    'time'   => 60,     // every minute (bounded by how often cron runs)
    'sync'   => TRUE,   // apply Migrate's --sync behaviour (delete stale destination rows)
  ],
];
```

Equivalent Drush, for reference: `drush mim migration_1 --update`,
`drush mim migration_2`, `drush mim migration_3 --sync`.

## Per-migration keys

| Key | Type | Effect |
|---|---|---|
| `time` | int (seconds) | Minimum interval between runs. Next run stored in State as `"{id}_next_execution"`; a run fires when `request_time > next_execution`. |
| `update` | bool (optional) | Calls `getIdMap()->prepareUpdate()` before import, so already-migrated rows are re-imported. |
| `sync` | bool (optional) | Sets `syncSource = TRUE`, so destination items missing from the source are removed. |

## Mechanics (`migrate_scheduler_cron()`)

1. Loads `\Drupal::config('migrate_scheduler')->get('migrations')`; returns if empty.
2. For each id: if `request_time > state("{id}_next_execution")`, sets the next execution to
   `request_time + time`, then instantiates the migration plugin.
3. Forces the migration status to `IDLE` if it isn't (recovers stuck migrations), applies
   `update`/`sync`, and runs `MigrateExecutable::import()` with a `MigrateMessage`.
4. If `migrate_plus` is enabled, updates its `migrate_last_imported` keyvalue for the migration.

## Operational notes

- Because it hangs off cron, the real cadence is `max(time, cron interval)`. For a 60-second
  schedule you must run cron at least that often (e.g. an external `drush cron`).
- Migration ids are the plugin ids (e.g. `drush migrate:status` names). A non-existent id is
  skipped safely (the created instance is checked before use).
- Long imports run inside the cron request — schedule heavy migrations mindful of cron timeout.
