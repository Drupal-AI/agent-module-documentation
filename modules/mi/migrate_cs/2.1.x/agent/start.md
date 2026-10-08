# Migrate Cron Scheduler — agent index

Runs Migrate migrations on cron, per-migration toggle + interval + mode. Thin scheduler over core
`migrate` that shells out to `drush migrate:import`. One settings form; a `hook_cron` runner.
No permissions of its own (form uses `administer site configuration`); no config schema; no plugins;
no Drush commands of its own.

- **Settings form, config keys, and the cron run algorithm** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `migrate_cs.options`, flat keys per migration: `<id>_cs` (bool),
  `<id>_interval` (seconds), `<id>_type` (`normal` | `update` | `delete`).
- Form route `migrate_cs.admin_settings_form` → `/admin/config/system/migrate-cs`.
- Last run time per migration in **state**: `migrate_cs.last_run.<id>`.
- Cron runner is `CronHooks::cron()` (`src/Hook/CronHooks.php`, `#[Hook('cron')]`). It requires a
  Drush container (`drush core:cron`); under plain web cron it logs a notice and does nothing.
- Due + IDLE migrations are run as `drush migrate:import <id> [--update | --sync/--delete]`;
  `last_run` updates only on success, and a failed run resets the migration to IDLE.
- Depends only on `migrate`; the migrations themselves are defined elsewhere.
