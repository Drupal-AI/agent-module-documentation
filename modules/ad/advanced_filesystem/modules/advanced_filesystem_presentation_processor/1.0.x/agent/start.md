<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Presentation Processor (advanced_filesystem_presentation_processor) — agent index

PPTX processing submodule of Advanced FileSystem (1.0.27). Pure-PHP slide/notes/metadata extraction plus LibreOffice PDF conversion and Ghostscript per-slide image gallery. Module type: module.

## Dependencies
- `drupal:file`, `drupal:media`, `advanced_filesystem:advanced_filesystem`.
- External binaries (feature-gated, `is_executable` checked): `soffice` (LibreOffice) for PDF; `gs` (Ghostscript) for per-slide images. PHP `ext-zip` (ZipArchive) required for extraction.

## What it provides
- Service `advanced_filesystem_presentation_processor.service` → `PresentationProcessorService`.
- QueueWorker `adfs_presentation_process` → `PresentationQueueWorker` (processes a `{fid}` on cron when `auto_process` on).
- Media source plugin `PresentationProcessorSource` (`src/Plugin/media/Source`).
- Config object `advanced_filesystem_presentation_processor.settings` (+ schema). See [config/settings.md](config/settings.md).
- Permission `administer advanced_filesystem_presentation_processor` (restricted) gates every route/download; `process advanced_filesystem_presentation_processor` also declared.
- DB table (`.install`): `adfs_presentation_jobs`.
- Hooks in `.module`: `file_insert` (auto-queue PPTX mimes), `file_download` (permission-gate private dirs), `entity_operation` (Presentation Info / Processar links).

## Routes (all require `administer advanced_filesystem_presentation_processor`)
- `.settings`, `.dashboard`, `.batch`.
- `.file_view` `/admin/content/files/{file}/presentation` — Presentation Info (escaped text + thumbnail).
- `.slide_gallery` `/admin/content/files/{file}/presentation/slides` — slide image gallery.
- `.file_process` `/admin/content/files/{file}/presentation/process` — per-file processing form.

## Solution docs
- [config/settings.md](config/settings.md) — install, config keys, routes, permissions, operating it.
- [api/service.md](api/service.md) — `PresentationProcessorService` method reference.
