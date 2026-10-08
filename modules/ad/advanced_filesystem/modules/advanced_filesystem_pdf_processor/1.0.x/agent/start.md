<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: PDF Processor (advanced_filesystem_pdf_processor) — agent index

PDF processing submodule of Advanced FileSystem (1.0.27). External-tool pipeline over pdftotext, pdfinfo, Ghostscript, Tesseract and poppler. Module type: module.

## Dependencies
- `drupal:file`, `drupal:media`, `advanced_filesystem:advanced_filesystem`.
- External binaries (feature-gated, `is_executable` checked): `pdftotext`, `pdfinfo`, `gs`, `convert`, `tesseract` (`/usr/bin/tesseract`, hardcoded), `pdfimages` (`/usr/bin/pdfimages`, hardcoded).

## What it provides
- Service `advanced_filesystem_pdf_processor.service` → `PdfProcessorService` (all extraction and derivative logic).
- QueueWorker `adfs_pdf_process` → `PdfQueueWorker` (processes a `{fid}` item on cron when `auto_process` on).
- Media source plugin `PdfProcessorSource` (`src/Plugin/media/Source`).
- Config object `advanced_filesystem_pdf_processor.settings` (+ schema). See [config/settings.md](config/settings.md).
- Permissions: `administer advanced_filesystem_pdf_processor` (restricted) gates every route/download; `process advanced_filesystem_pdf_processor` also declared.
- DB tables (`.install`): `adfs_pdf_jobs`, `adfs_pdf_derivatives`, `adfs_pdf_page_thumbs`.
- Hooks in `.module`: `file_insert` (auto-queue `application/pdf`), `file_download` (permission-gate private dirs), `entity_operation` (file operation links).

## Routes (all require `administer advanced_filesystem_pdf_processor`)
- `.settings`, `.dashboard` (+ `/clean`, `/reprocess`), `.batch`.
- `.file_view` `/admin/content/files/{file}/pdf` — PDF Info (escaped text preview + metadata + gallery).
- `.file_process`, `.pdf_edit`, `.pdf_merge`, `.pdf_diff`, `.derivative_delete`, `.derivative_export`.
- `.pdf_autocomplete` `/adfs/pdf/autocomplete` — also permission-gated.

## Solution docs
- [config/settings.md](config/settings.md) — install, config keys, routes, permissions, operating it.
- [api/service.md](api/service.md) — `PdfProcessorService` method reference and derivative model.
