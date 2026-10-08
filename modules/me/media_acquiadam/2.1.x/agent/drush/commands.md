# Drush commands

Defined in `src/Commands/AcquiadamCommands.php` (registered via `drush.services.yml`).

| Command | Aliases | Args / options | Purpose |
|---|---|---|---|
| `acquiadam:sync` | `acquiadam-sync` | `--method=`, `--date=` | Sync DAM assets into Drupal media (respects sync method/date). Validated by `validateSync()`. |
| `acquiadam:update` | `acquiadam-update` | `<file>`, `--delimiter=,` | Bulk-update stored asset references from a CSV file. Validated by `validateUpdate()`. |
| `acquiadam:migrate` | `admig`, `acquiadam-migrate` | — | Run the migration to the newer `acquia_dam` module. |
| `acquiadam:migrate-data` | `admigd`, `acquiadam-migratedata` | — | Migrate asset/media data as part of the migration. |
| `acquiadam:post-migrate` | `adpmig`, `acquiadam-pmigrate` | — | Post-migration cleanup/finalization step. |

Examples:

```bash
ddev drush acquiadam:sync --method=updated_date
ddev drush acquiadam:update /path/to/assets.csv --delimiter=';'
ddev drush acquiadam:migrate && ddev drush acquiadam:migrate-data && ddev drush acquiadam:post-migrate
```

The migration commands mirror the guided UI at `/admin/config/acquia-dam/migration` and move an existing
Media: Acquia DAM site onto the `acquia_dam` module.
