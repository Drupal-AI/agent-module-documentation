<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Archive (advanced_filesystem_archive) — agent index

ZIP tooling over Drupal managed files: **download** a set of files as one ZIP, **extract** an
uploaded ZIP into managed File entities, and **browse** a ZIP's listing without extracting.
Submodule of Advanced FileSystem. Package `Advanced Filesystem`. Core `^10 || ^11 || ^12`.
Depends on core **`file`** and **`advanced_filesystem`**. Version 1.0.27.

- **Service API, routes, permissions, config, DB tables, how to operate it** →
  [api/archive-service.md](api/archive-service.md)

## What it provides

- **Service** `advanced_filesystem_archive.service` → `Service\ArchiveService`
  (`streamZipDownload()`, `browseZip()`, `extractZip()`, lineage + log getters).
- **Routes** (`advanced_filesystem_archive.routing.yml`):
  - `.settings` — `ArchiveSettingsForm` at `/admin/config/media/advanced_filesystem/archive`
    (`administer advanced_filesystem_archive`).
  - `.download` — `ArchiveDownloadForm` (`download files as zip advanced_filesystem_archive`).
  - `.download_stream` — `ArchiveDownloadController::stream` at `/adfs/archive/download`
    (same perm, **`_csrf_token: 'true'`**; reads FIDs from session, streams ZIP).
  - `.extract` — `ArchiveExtractForm` (`extract zip advanced_filesystem_archive`).
  - `.browse` — `ArchiveBrowseController::browse` at
    `/admin/content/files/{file}/archive/browse` (`browse zip advanced_filesystem_archive`).
  - `.log` — `ArchiveLogController::log` (`administer advanced_filesystem_archive`).
- **Permissions** (`*.permissions.yml`): `administer …` (restrict access), plus
  `download files as zip …`, `extract zip …`, `browse zip …`.
- **Config** object `advanced_filesystem_archive.settings` (schema in `config/schema/`):
  `max_files_per_download`, `max_zip_size_mb`, `max_extract_file_size_mb`,
  `default_extract_scheme`, `default_extract_subdir`.
- **DB tables** (`*.install`): `adfs_archive_downloads` (download audit log),
  `adfs_archive_extractions` (ZIP→managed-file lineage).
- No plugins, no Drush, no hooks beyond menu/task/action links.

## Mechanism (from source)

- **Download**: `streamZipDownload(int[] $fids)` caps FID count/size, logs the request
  (uid, fids_json, count, size, ip) to `adfs_archive_downloads`, then returns a
  `StreamedResponse` that builds a `ZipArchive` in a temp file (de-duplicating names with a
  `_N` suffix) and `fpassthru`s it. `ArchiveDownloadForm` stashes the selected FIDs in the
  session; `ArchiveDownloadController::stream` pops them and calls the service.
- **Extract**: `extractZip($zipFile, $scheme, $subdir, $skipExisting, $mimeFilter)` opens the
  ZIP, and per entry skips directories/dot-files/`__MACOSX/`, enforces the per-file size cap,
  optionally MIME-filters, writes the entry to a temp file, then `file_system->copy()`s it to
  the destination and creates a managed `File`. Entry names are reduced with `basename()` and
  the target basename is passed through `preg_replace('/[^a-zA-Z0-9._\-]/','_', …)`.
- **Browse**: `browseZip($file)` iterates `statIndex()` and returns entry metadata sorted
  directories-first; nothing is written to disk.

## Notes

- Uses **PHP `ZipArchive` only** — no shell-outs to `zip`/`unzip`.
- The download stream route carries a CSRF token; the download/extract/browse admin forms and
  pages are permission-gated (see the service doc for exact perms).
