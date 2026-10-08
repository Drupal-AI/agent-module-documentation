<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Inspector — services & data model

All services are defined in `file_inspector.services.yml`. Static Batch API callbacks re-fetch
services from the container (`\Drupal::service(...)`) rather than using injected ones.

## Data model

Table **`file_inspector`** (`hook_schema`, `file_inspector.install`): `id` (serial PK), `name`
(varchar 255), `path` (varchar 512, binary, **unique key**), `mime_type` (varchar 128), `size`
(bigint), `status` (tinyint), `created`, `updated` (int timestamps), `media_id` (int unsigned,
nullable). Indexes: `status_id`, `status_created`, `mime_status`.

- `src/Constants/FileStatusInterface.php` — status codes: `UNPROCESSED=0`, `MANAGED=1`,
  `UNMANAGED=2`, `IMPORTED=3`, `DELETED=4`, `WEB_EMBEDDED=5`.
- `src/Constants/FileDataInterface.php` — field-name constants (`ID`, `NAME`, `PATH`, `MIME_TYPE`,
  `SIZE`, `STATUS`, `CREATED`, `UPDATED`, `MEDIA_ID`).

## `file_inspector.data_service` → `DataService` (`src/Service/DataService.php`)

All DB access to the table. Uses the query builder with bound conditions/placeholders throughout
(no string concatenation). Key methods:

- `checkFileData()` — validates required fields and max lengths (255/512/128) before insert.
- `insertFileData()` / `bulkInsertFileData()` — chunked inserts (chunk size 100), each chunk in its
  own transaction so a duplicate-`path` collision skips only that chunk.
- `getFileDataById()`, `bulkGetFileDataById()`, `getFileDataByPath()`.
- `setStatus()`, `bulkSetStatus()`, `bulkSetStatusByPath()`, `setImportedMedia()` — status writes
  are validated against the known status set (`isValidStatus()`).
- `getStatusCounts()` — grouped counts, cached under key `file_inspector:status_counts` with tag
  `file_inspector_statistics`.
- `getFileIdsByStatus()` — cursor-paginated (5000/page) to bound memory.
- `truncate()`. Writes invalidate `file_inspector_statistics` + `file_inspector` cache tags.

## `file_inspector.inspect_files` → `InspectFiles` (`src/Service/InspectFiles.php`)

Filesystem traversal + classification. Injects `file_system`, config, logger, data service,
`stream_wrapper_manager`, `path_validator`, database, `file.mime_type.guesser`, `module_handler`.

- `filesIterator($limit, $wrapper)` — a `\Generator`. Validates `$wrapper` against
  `inspection.stream_wrappers` (throws otherwise), resolves the wrapper's realpath, and walks it
  with `RecursiveDirectoryIterator` (SKIP_DOTS) wrapped in a `RecursiveCallbackFilterIterator` that
  drops any entry whose basename starts with `.`. **Symlinks are skipped** (`isLink()`), dotfiles
  skipped, and every yielded path passes `PathValidator::validatePath()`, exclusion check, embedded
  check, and `is_readable()`.
- `embeddedEntriesIterator($wrapper)` — yields only the entry file (depth 1 and depth 2) inside each
  configured embedded web folder; rejects symlinks at root and sub-folder level.
- `extractMetadata($path)` — returns name/path/mime/size/status/timestamps. Size via `@filesize`,
  MIME via `getMimeType()`. **Does not read or parse file *contents*** — no image/XML/SVG/office
  parsing, no external tool invocation.
- `getMimeType($path)` — delegates to the injected Symfony MIME guesser (extension-based in Drupal),
  falling back to `application/octet-stream`.
- `isManagedFile()` / `bulkCheckManagedFiles()` — `SELECT` against `file_managed.uri` (`IN` for
  bulk) to decide MANAGED vs UNMANAGED.
- `isExcludedPath()`, `isEmbeddedWebPath()`, `isAllowedMimeType()` — config-driven predicates.

## `file_inspector.path_validator` → `PathValidator` (`src/Service/PathValidator.php`)

Central security gate. `validatePath()` rejects empty paths, null bytes (`\x00` on raw and
`rawurldecode()`d input), and directory traversal (`..[/\\]` on raw and decoded input), logging each
violation. `getStreamWrapper()` extracts the scheme and rejects it unless it is both in
`inspection.stream_wrappers` and a registered Drupal scheme. Every filesystem read/delete/import
path in the module is required to pass through this service first.

## `file_inspector.manage_files` → `ManageFiles` / `ManageFilesWithMedia`

Base `ManageFiles` (`src/Service/ManageFiles.php`): `removeFile()` and `importFile()`.
`removeFile()` re-validates the path, confirms existence, writability and that it is a regular file,
deletes via `file_system->delete()`, then sets status DELETED. `importFile()` creates a managed
File entity (`createFileEntityFromData()` → `createFileEntity()`, reusing an existing File for the
same URI if present) and sets status IMPORTED. `canImportMedia()` returns FALSE here.

`ManageFilesWithMedia` (`src/Service/ManageFilesWithMedia.php`) extends it and overrides
`importFile()` to wrap File + Media creation in a DB transaction: it loads the target `media_type`,
resolves its source field, creates the Media entity, records the association via
`DataService::setImportedMedia()`, and rolls back on any failure. `canImportMedia()` returns TRUE.

**Strategy swap** — `FileInspectorServiceProvider::alter()` (`src/FileInspectorServiceProvider.php`)
checks the `container.modules` parameter; when `media` is present it rewrites the
`file_inspector.manage_files` definition to `ManageFilesWithMedia` and appends the `database`
argument, and sets `file_inspector.media_enabled = TRUE`. No hard dependency on Media.

## Batch services

- `file_inspector.batch_tracker` → `BatchTracker` (`src/Service/BatchTracker.php`) — `BatchForm`
  "Track files" button. `getBatchDefinition()` truncates the table and queues one `processBatch`
  op. Two-pass sandbox: pass 1 enumerates both iterators into in-memory queues (URIs only); pass 2
  drains up to `batch_size` items, calls `extractMetadata()`, filters by `isAllowedMimeType()`, and
  `bulkInsertFileData()`s. Embedded entries are stored directly as WEB_EMBEDDED. `$context[finished]`
  drives the progress bar.
- `file_inspector.batch_processor` → `BatchProcessor` (`src/Service/BatchProcessor.php`) — "Process
  tracked files" button. Loads UNPROCESSED ids in `batch_size` chunks and flips each to
  MANAGED/UNMANAGED using `bulkCheckManagedFiles()` + `bulkSetStatus()`.

Both expose `processBatch()`/`finishBatch()` as static callbacks and report processed/error counts
via messenger + logger.
