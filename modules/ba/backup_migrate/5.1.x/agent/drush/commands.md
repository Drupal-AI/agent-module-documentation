# Drush commands

Registered via `drush.services.yml` (`BackupMigrateCommands`).

| Command | Alias | Does |
|---|---|---|
| `backup_migrate:quick_backup` | `bb` | Run a backup. Options: `--source_id` (default `default_db`), `--destination_id` (default `private_files`), `--profile_id`, `-i` interactive. |
| `backup_migrate:schedule_backup` | `schedule_backup` | Run all scheduled backups that are due (call from cron/deploy). |
| `backup_migrate:sources` | `bam-sources` | List configured sources. |
| `backup_migrate:destinations` | `bam-destinations` | List configured destinations. |
| `backup_migrate:profiles` | `bam-profiles` | List settings profiles. |
| `backup_migrate:schedules` | `bam-schedules` | List schedules. |

Examples:
```
drush backup_migrate:quick_backup --source_id=entire_site --destination_id=private_files
drush bb                       # DB → private files with defaults
drush backup_migrate:schedule_backup
```
