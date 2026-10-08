# Configure Migrate Cron

Form `Drupal\migrate_cron\Form\AdminSettingsForm` at `/admin/config/system/migrate-cron`
(route `migrate_cron.admin_settings_form`, permission `administer site configuration`). It lists
every migration returned by `plugin.manager.migration` and writes to `migrate_cron.settings`.

## Per-migration settings (config `migrate_cron.settings`)

For each migration id, three flat keys:

| Key | Widget | Meaning |
|---|---|---|
| `<id>_cron` | checkbox "Run at cron" | Enable scheduled runs for this migration. |
| `<id>_interval` | number "Run at interval" | Seconds between runs. Empty / below the cron interval → runs every cron. |
| `<id>_skip_update` | checkbox "Don't update previously migrated entities" | If set, skips `prepareUpdate()` so already-imported rows are not re-imported. |

There is no config schema file, so these keys are untyped config. Details for a migration with
cron enabled are shown expanded and sorted to the top of the form.

## Cron run algorithm (`migrate_cron_cron` in `migrate_cron.module`)

For every migration definition:
1. Skip unless `<id>_cron` is truthy.
2. `last_run` = state `migrate_cron.last_run.<id>` (default 0); `interval` = `<id>_interval` or 0.
3. If `now - last_run >= interval`:
   - If the migration status is not IDLE, force it to `STATUS_IDLE` (clears stuck locks).
   - Save `now` to state `migrate_cron.last_run.<id>`.
   - Unless `<id>_skip_update`, call `$migration->getIdMap()->prepareUpdate()` (marks rows for
     re-import so source changes are pulled in).
   - Run `new MigrateExecutable($migration, new MigrateMessage())` then `->import()`.

## Notes

- Actual run frequency is bounded by how often Drupal cron fires — the interval only gates whether
  a due migration runs on a given cron tick.
- Because it always resets stuck migrations to IDLE, a migration left mid-run will be restarted on
  the next due tick.
- Migrations come from core `migrate` / `migrate_plus`; define them there (this module only
  schedules them).
