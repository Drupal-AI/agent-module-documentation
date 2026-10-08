# Configure Migrate Cron Scheduler

Form `Drupal\migrate_cs\Form\SettingsForm` (form id `migrate_cs_options`) at
`/admin/config/system/migrate-cs` (route `migrate_cs.admin_settings_form`, permission
`administer site configuration`). It lists every migration returned by `plugin.manager.migration`
and writes to `migrate_cs.options`. If no migrations exist it shows "There are no migrations."

## Per-migration settings (config `migrate_cs.options`)

For each migration id, three flat keys:

| Key | Widget | Meaning |
|---|---|---|
| `<id>_cs` | checkbox "Run at cron" | Enable scheduled runs for this migration. |
| `<id>_interval` | number "Run at interval" | Seconds between runs. Empty / below the cron interval → runs every cron. Disabled unless `_cs` is checked. |
| `<id>_type` | radios "Migration option" | `normal` (default), `update`, or `delete`. Disabled unless `_cs` is checked. |

There is no config schema file, so these keys are untyped config. On save the form deletes the whole
`migrate_cs.options` object first and rewrites it from the current migration list, so keys for
migrations that no longer exist are pruned (no orphaned config).

Mode meaning:
- `normal` — plain import of unprocessed source items.
- `update` — adds `--update`: re-process previously imported items with current source data.
- `delete` — adds `--sync` when `migrate_tools` is installed, otherwise `--delete`: remove
  destination records that are missing from the source.

## Cron run algorithm (`CronHooks::cron()`, `src/Hook/CronHooks.php`)

Registered via `#[Hook('cron')]`. Steps:
1. If the Drush class is unavailable or `Drush::hasContainer()` is false, log a notice and return —
   scheduling only works when cron runs through Drush (e.g. `drush core:cron`).
2. For every migration definition, skip unless `<id>_cs` is truthy.
3. `last_run` = state `migrate_cs.last_run.<id>` (default 0); `interval` = `<id>_interval` or 0.
   Skip if `now - last_run < interval`.
4. `createInstance(<id>)`; skip if it fails.
5. If the migration status is not `STATUS_IDLE`, log a warning and skip (does not force-reset it,
   and does not touch `last_run`).
6. Build args from `<id>_type`: `update` → `--update`; `delete`/`sync` → `--sync` if
   `migrate_tools` is enabled else `--delete`; otherwise no flag.
7. Run `Drush::drush($aliasManager->getSelf(), 'migrate:import', [<id>, ...flags])->run()`.
   - On success: set state `migrate_cs.last_run.<id>` = `now`.
   - On failure: log a warning with exit code and error output, and reset the migration to
     `STATUS_IDLE`. `last_run` is not updated, so it retries next due tick.

## Notes

- Actual run frequency is bounded by how often Drupal cron fires — the interval only gates whether a
  due migration runs on a given cron tick.
- A migration already running (non-idle) is skipped rather than restarted; only *failed* runs are
  reset to IDLE.
- Migrations come from core `migrate` (and typically `migrate_plus` config entities); define them
  there — this module only schedules them.
