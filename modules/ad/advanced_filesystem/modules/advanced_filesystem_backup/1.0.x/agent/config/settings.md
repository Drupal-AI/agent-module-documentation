<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backup — configuration, orchestration, run flow

## Install / enable

`drush en advanced_filesystem_backup`. `.install` `hook_schema()` creates
**`advanced_filesystem_backup_runs`** (id, uuid, label, started, completed, status, phase,
trigger_method, backup_mode, total_files, total_bytes, processed_files, archive_path,
archive_size, storage_backends, error_message). ZIP mode needs the PHP `ZipArchive` extension;
the FTP backend needs the `ftp` extension.

## Config object `advanced_filesystem_backup.settings`

Install defaults (`config/install/…settings.yml`), schema in `config/schema/…schema.yml`:

- `enabled` (bool, true).
- `cron`: `enabled` (bool, false), `interval` (int seconds, 86400), `trigger_method`
  (`queue`|`batch`; cron always falls back to queue).
- `retention.keep_count` (int, 5) — archives to keep per backend (0 = keep all).
- `schemes` (sequence, `[public]`) — local stream-wrapper schemes to include.
- `backup_mode` (`zip`|`files`, `zip`).
- `exclusions` (string) — newline/comma glob patterns (matched against full URI and basename).
- `temp_dir` (string, `private://advanced_filesystem_backup/temp`) — where the ZIP is built.
- `files_per_chunk` (int, 50) — files per batch step / queue item.
- `storage_backends` (sequence) — each `{id, type, label, enabled, config}`; `config` is
  schema-typed **`ignore`** (plugin-specific, stored as-is in this config object).

`Form\BackupSettingsForm` builds scheme checkboxes from `stream_wrapper_manager` LOCAL wrappers,
an exclusions textarea, cron/retention sections and a dynamic AJAX list of backends. Each backend
row renders its plugin's `buildConfigForm()` (refreshed on type change). `submitForm()` normalises
machine IDs (auto `backend_N`, de-duplicated) and — for the `password` and `secret_key` fields —
preserves the previously saved value when the field is left blank, so secrets survive re-saves.

## BackupManager (`advanced_filesystem_backup.manager`)

Responsibilities and key methods:

- **Lock** — `isLocked()` (auto-expires a stale lock after `LOCK_TTL` = 7200 s and marks its run
  failed), `acquireLock()`, `releaseLock()`, `forceResetRun()`.
- **Run lifecycle** — `createRun()`, `updateRun()`, `finishRun()`, `cancelRun()`,
  `deleteRunRecord()`, `getRunHistory()`, `getActiveRun()`; real-time progress in State via
  `updateRunState()`/`getRunState()`.
- **Collection** — `collectFiles(schemes, exclusions)` recurses each scheme's realpath
  (`scanDirectory()`), returning `{uri, realpath, size}`; `matchesExclusion()` uses `fnmatch`.
- **Archive** — `getTempArchivePath()`, `openArchive()` (ZipArchive::CREATE, append mode),
  `addFilesToArchive()` (stores `scheme/relative/path` so restore can reconstruct the URI).
- **Backends** — `getEnabledStorageBackends()`, `getStoragePlugin(backend)`,
  `uploadToBackends()` (ZIP), `uploadFilesToBackends()` (files mode), `applyRetention()` /
  `applyFilesRetention()`.
- **Triggering** — `triggerQueue()`, `getBatchDefinition()`, `buildRemoteName()`
  (`backup_<site>_<Ymd_His>_r<run>.zip`), `buildRemotePrefix()` (files mode).

## Run flow

- **Batch** (`Batch\BackupBatch`, interactive): ZIP = collect → buildArchive (chunked) → upload →
  cleanup; files = collect → uploadFiles (chunked) → cleanupFiles.
- **Queue** (`BackupQueueWorker`, phased so it survives PHP timeouts): `start` →
  `archive_chunk`* → `upload` → `cleanup` (ZIP), or `start` → `upload_files`* → `cleanup` (files).
  The file list is stashed in State (`advanced_filesystem_backup.queue_files_<run>`) between phases.
- **Cron** (`hook_cron`): if `cron.enabled` and `interval` elapsed and not locked, calls
  `triggerQueue('cron')`.

`BackupDashboardController` exposes Run batch / Queue / Process queue now (drains the queue inline),
Cancel, Force reset and Delete run, plus `progressJson()` for the live progress bar.

## Restore & download

- **Restore** — `Form\BackupRestoreForm` (ConfirmForm; shows run info, an age warning past
  `restore.age_warning_days`, and a required overwrite-acknowledgement checkbox) dispatches
  `Batch\BackupRestoreBatch`: `prepare()` locates the archive (prefers a local real path, else
  downloads from a backend to temp), `extract()` streams entries back to their original
  `scheme://path` URIs — `extractZip()` reads chunks with `ZipArchive::RDONLY`, `extractFiles()`
  re-downloads each remote file. Both validate the scheme via `stream_wrapper_manager->isValidScheme()`.
- **Download** — `Controller\BackupRestoreController::download(run_id)` returns a
  `BinaryFileResponse`: serves a Local backend file directly, otherwise downloads from the first
  available backend to a temp file (deleted after send).

All cloud/FTP transfers use the plugin backends; see
[plugins/storage-backends.md](../plugins/storage-backends.md).
