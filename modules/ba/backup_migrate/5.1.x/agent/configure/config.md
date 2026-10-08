# Configuration

![Backup and Migrate — Backup tab](../../../../../../../screenshots/backup_migrate/5.1.x/backup.png)

UI at `/admin/config/development/backup_migrate`. Backups are driven by four config entity
types (schema `config/schema/backup_migrate.schema.yml`), exportable like any config:

| Entity | Machine type | Purpose |
|---|---|---|
| Source | `backup_migrate_source` | What to back up. Bundles: `defaultdb`, `mysql`, `entiresite`, `drupalfiles`, `filedirectory`. |
| Destination | `backup_migrate_destination` | Where backups go. Bundle: `directory` (+ browser download, private/public files provided at install). |
| Schedule | `backup_migrate_schedule` | Recurring backup: source + destination + period, keep-N rolling copies. |
| SettingsProfile | `backup_migrate_settings_profile` | Reusable set of options (compression, table exclusions, naming, encryption). |

Install-provided config (`config/install/`): sources `default_db`, `entire_site`,
`public_files`, `private_files`; destination `private_files`; a `daily_schedule`.

Quick backup form defaults: source `default_db` → destination `private_files`.
Schedules run under cron; each keeps a configurable number of latest backups and deletes
the oldest. Encryption of archives requires the optional `defuse/php-encryption` library.
