<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Backup (advanced_filesystem_backup) — agent index

Backs up selected stream-wrapper file trees to pluggable storage backends (Local, FTP/FTPS, S3, R2,
GCS) as a ZIP archive or file-by-file, via Batch / queue / cron, with a run-history dashboard,
retention, restore and download. Package `Advanced Filesystem`. Depends on core **`file`**,
**`user`** and **`advanced_filesystem`**. Core `^10 || ^11 || ^12`. GPL-2.0-or-later. Version 1.0.27
(version-dir 1.0.x).

- **Config object, settings form, routes, the BackupManager service, batch/queue flow** →
  [config/settings.md](config/settings.md)
- **The `BackupStorage` plugin type and the five built-in backends** →
  [plugins/storage-backends.md](plugins/storage-backends.md)

## What it actually is

- Plugin type **`BackupStorage`**: annotation `Annotation\BackupStorage`, manager
  `BackupStoragePluginManager` (service `plugin.manager.advanced_filesystem_backup_storage`,
  discovers `Plugin/BackupStorage/*`), interface `BackupStorageInterface`.
- Orchestrator service **`advanced_filesystem_backup.manager`** → `BackupManager` (lock, run
  lifecycle, file collection, ZIP building, backend delegation, retention, triggering).
- Execution: Batch callbacks `Batch\BackupBatch` (collect → buildArchive/uploadFiles → upload →
  cleanup) and `Batch\BackupRestoreBatch` (prepare → extract); queue worker
  `Plugin\QueueWorker\BackupQueueWorker` (id `advanced_filesystem_backup_queue`, phased:
  start → archive_chunk/upload_files → upload → cleanup).
- UI: `Controller\BackupDashboardController` (dashboard, run/queue/cancel/reset/delete,
  progress.json), `Controller\BackupRestoreController::download()`, `Form\BackupSettingsForm`,
  `Form\BackupRestoreForm` (ConfirmForm).
- Config object **`advanced_filesystem_backup.settings`** (schema in `config/schema/`), DB table
  **`advanced_filesystem_backup_runs`** (run history), one permission
  **`administer advanced_filesystem_backup`** (`restrict access: true`). No entities, no Drush.

## Routes (all `_permission: 'administer advanced_filesystem_backup'`, `_admin_route`)

Base path `/admin/config/media/advanced_filesystem/backup`:
`.dashboard` (``), `.settings` (`/settings` form), `.run_batch` (`/run`), `.run_queue` (`/queue`),
`.process_queue` (`/process-queue`), `.cancel` (`/cancel/{run_id}`), `.delete_run`
(`/delete/{run_id}`), `.reset_run` (`/reset/{run_id}`), `.restore` (`/restore/{run_id}` ConfirmForm),
`.download` (`/download/{run_id}` streams the archive), `.progress_json` (`/progress.json`).
`{run_id}` is constrained to `\d+`.
