Cleans up the Entity IO export storage directory, manually or automatically on a schedule.

---

Entity IO Purge removes the JSON files that Entity IO writes to its export storage directory. An
admin UI lets you select and confirm deletion of all export files or only those for a chosen entity
type, and an optional automatic purge runs from cron at a configurable frequency (daily, weekly, or
monthly), tracking the last run in state. It reuses Entity IO's `ExportDirectory` helper to locate
and delete files.

---

- Delete all generated Entity IO export files from the admin UI.
- Purge only the exports for a specific entity type (e.g. node).
- Confirm deletions through a dedicated confirm step before removal.
- Enable automatic cleanup so exports do not accumulate on disk.
- Run automatic purges daily to keep storage minimal.
- Run automatic purges weekly (the default frequency).
- Run automatic purges monthly for infrequent cleanup.
- Free disk space consumed by large media/file exports.
- Reset the export directory before a fresh full export.
- Trigger an immediate manual purge that bypasses the frequency check.
- Purge multiple selected entity types in one operation.
- Keep a scheduled housekeeping routine for export artifacts.
- Prevent stale exports from being re-imported by accident.
- Audit how many files were removed via the logged purge count.
- Combine with the export/queue workflow so temporary files are cleaned after transfer.
