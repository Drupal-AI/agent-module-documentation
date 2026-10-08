<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Batch Export (config_batch_export) — agent index

Adds an **"Export in batch"** button to core's full config-export form
(`/admin/config/development/configuration/full/export`) that builds the config tarball through
the **Batch API** instead of one request — avoiding PHP timeouts / CDN response-time limits on
large sites. Package `Core`. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version 2.0.0.

- **Full mechanism, routes, permissions, services, batch flow, download** →
  [config/export.md](config/export.md)

## What it actually is (from source)

- **No config, no permissions, no plugins, no Drush, no config schema of its own.** It reuses the
  core **`export configuration`** permission. `configure` in `.info.yml` points at `config.sync`.
- Depends only on core **`config`**, **`file`**, **`datetime`**.
- One controller: `ConfigBatchExportController` (`src/Controller/ConfigBatchExportController.php`)
  **extends `\Drupal\config\Controller\ConfigController`**. One thin service class
  `Config\Storage` extends core `CachedStorage` (used with a **null cache backend** so reads are
  never cached during export).
- Two hooks in `config_batch_export.module`: `hook_form_config_export_form_alter()` injects the
  batch button; `hook_file_download()` authorizes serving the finished private archive.

## Routes (both `_permission: 'export configuration'`)

- `config_batch_export.export_download` — GET
  `/admin/config/development/configuration/full/export-download-batch` →
  `ConfigBatchExportController::downloadExport()`; acquires a lock, creates a temp file entity,
  sets the batch, runs `batch_process()`.
- `config_batch_export.export_download_file` — GET `…/export-download-batch-file/{file}`
  (`{file}` = `entity:file`) → `downloadExportFile()`; streams the archive via core
  `FileDownloadController`.

## Services (`config_batch_export.services.yml`)

- `config_batch_export.config_storage` → `Config\Storage` (args `@config.storage.active`,
  `@config_batch_export.cache_backend.null`).
- `config_batch_export.cache.factory.null` (`NullBackendFactory`) +
  `config_batch_export.cache_backend.null` (its `get('config')`) — a no-op cache backend.

## Batch flow

`callbackBatchJob()` (static) appends each config as YAML to an uncompressed tar with
`ArchiveTar::addString()` in slices of `BATCH_SIZE = 10`; `callbackBatchFinished()` gzips the tar
to `private://configs.tar.gz` (or moves the `.tar` if zlib is missing), deletes the temp file,
releases the lock, and shows a download link. See [config/export.md](config/export.md).
