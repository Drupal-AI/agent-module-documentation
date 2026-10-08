# Permissions

From `backup_migrate.permissions.yml` (all `restrict access: true` — grant carefully):

| Permission | Gates |
|---|---|
| `perform backup` | Back up any of the available sources. |
| `access backup files` | Access and download previously created backup files. |
| `restore from backup` | Restore the site's database from a backup file. |
| `administer backup and migrate` | Edit profiles, schedules, sources and destinations. |
