<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Document Processor (advanced_filesystem_document_processor) — agent index

DOCX processing submodule of Advanced FileSystem (1.0.27). Pure-PHP text/metadata extraction plus LibreOffice/Ghostscript conversion and PDF operations. Module type: module.

## Dependencies
- `drupal:file`, `drupal:media`, `advanced_filesystem:advanced_filesystem`.
- External binaries (optional, feature-gated): `soffice` (LibreOffice) for PDF/HTML/ODT; `gs` (Ghostscript) for PDF sign/merge/range/thumbnails. PHP `ext-zip` (ZipArchive) required for all read/write DOCX ops.

## What it provides
- Service `advanced_filesystem_document_processor.service` → `DocumentProcessorService` (all extraction, conversion and derivative logic).
- QueueWorker `adfs_document_process` → `DocumentQueueWorker` (processes a `{fid}` item; runs on cron when `auto_process` is on).
- Media source plugin `DocumentProcessorSource` (`src/Plugin/media/Source`).
- Config object `advanced_filesystem_document_processor.settings` (+ schema). See [config/settings.md](config/settings.md).
- Permissions: `administer advanced_filesystem_document_processor` (restricted) gates every route/download/operation; `process advanced_filesystem_document_processor` is also declared.
- DB tables (see `.install`): `adfs_document_jobs`, `adfs_document_derivatives`, `adfs_document_page_thumbs`.
- Hooks in `.module`: `file_insert` (auto-queue Word mimes), `file_download` (permission-gate private derivative dirs), `entity_operation` (file operation links).

## Routes (all require `administer advanced_filesystem_document_processor`)
- `.settings` `/admin/config/media/advanced_filesystem/document-processor` — settings form.
- `.dashboard` (+ `/clean`, `/reprocess`) — coverage stats, cleanup, reprocess-failed.
- `.batch` — batch processing.
- `.file_view` `/admin/content/files/{file}/document` — Document Info (escaped text preview + metadata + thumbnails).
- `.file_process`, `.document_edit`, `.document_merge`, `.document_diff` — per-file operation forms.
- `.derivative_delete`, `.derivative_export` `/admin/content/files/{file}/document/derivative/{did}/…`.

## Solution docs
- [config/settings.md](config/settings.md) — install, config keys, routes, permissions, operating it.
- [api/service.md](api/service.md) — `DocumentProcessorService` method reference and derivative model.
