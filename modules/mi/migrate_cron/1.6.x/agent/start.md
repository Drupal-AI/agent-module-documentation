# Migrate Cron — agent index

Runs Migrate migrations on cron, per-migration toggle + interval. Thin scheduler over core
`migrate` + `migrate_plus`. One settings form; a `hook_cron` runner. No permissions of its own
(form uses `administer site configuration`); no config schema.

- **Settings form, config keys, and the cron run algorithm** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `migrate_cron.settings`, flat keys per migration: `<id>_cron` (bool),
  `<id>_interval` (seconds), `<id>_skip_update` (bool).
- Form route `migrate_cron.admin_settings_form` → `/admin/config/system/migrate-cron`.
- Last run time per migration in **state**: `migrate_cron.last_run.<id>`.
- `migrate_cron_cron()` (in `migrate_cron.module`) resets due migrations to IDLE, runs
  `MigrateExecutable::import()`, and calls `getIdMap()->prepareUpdate()` unless skip-update.
- Depends on `migrate` and `migrate_plus`; the migrations themselves are defined elsewhere.
