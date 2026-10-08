<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF Processor — install, config, routes

## Install / enable
`drush en advanced_filesystem_pdf_processor`. Requires `file`, `media`, `advanced_filesystem`. Install creates `adfs_pdf_jobs`, `adfs_pdf_derivatives`, `adfs_pdf_page_thumbs`. Feature availability is gated at runtime by `is_executable()` on each configured binary; missing tools cause the relevant op to no-op / record a `failed` derivative rather than error.

## Config object: `advanced_filesystem_pdf_processor.settings`
Defined in `config/install/…settings.yml`, typed in `config/schema/…schema.yml`. Read via `PdfProcessorService::config()`.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `pdftotext_bin` | string | `/usr/bin/pdftotext` | Text extraction binary. |
| `pdfinfo_bin` | string | `/usr/bin/pdfinfo` | Metadata / page-count binary. |
| `gs_bin` | string | `/usr/bin/gs` | Ghostscript (thumbnails, PDF/A, all page/merge/watermark/password ops). |
| `convert_bin` | string | `/usr/bin/convert` | ImageMagick (reported in system status). |
| `thumbnail_width` | int | `400` | Thumbnail / page-image width in px. |
| `generate_thumbnail` | bool | `true` | First-page thumbnail during `process()`. |
| `extract_text` | bool | `true` | Run pdftotext during `process()`. |
| `export_pdfa` | bool | `false` | Auto PDF/A export during `process()`. |
| `detect_pii` | bool | `true` | Run PII regex over extracted text. |
| `auto_process` | bool | `false` | Queue PDF uploads on `hook_file_insert`. |
| `max_file_size_mb` | int | `100` | Files larger than this are skipped (`0` = unlimited). |
| `thumbnail_dir` | string | `private://adfs_pdf_thumbnails` | First-page thumbnail dir. |
| `pdfa_dir` | string | `private://adfs_pdf_pdfa` | PDF/A export dir. |

`tesseract` (`ocrFile()`) and `pdfimages` (`extractPdfImages()`) paths are hardcoded to `/usr/bin/…` and are not configurable.

Settings form: `Form\PdfSettingsForm` at route `.settings`.

## Routes & permissions
Every route in `advanced_filesystem_pdf_processor.routing.yml` requires `_permission: 'administer advanced_filesystem_pdf_processor'` (declared `restrict access: true`) and is an `_admin_route`. This includes the non-admin-path `/adfs/pdf/autocomplete` endpoint, which is also permission-gated. No anonymous / `_access: TRUE` routes exist. Per-file routes take an `entity:file` `{file}` (`file: \d+`). The `process advanced_filesystem_pdf_processor` permission is declared but the shipped routes gate on `administer …`.

Private derivative dirs (`adfs_pdf_thumbnails`, `adfs_pdf_page_thumbs`, `adfs_pdf_derivatives`, `adfs_pdf_splits`, `adfs_pdf_pdfa`) are served only to holders of `administer advanced_filesystem_pdf_processor` via `hook_file_download`; others get `-1`.

## Operating it
- Automatic: enable `auto_process`; `hook_file_insert` enqueues `application/pdf` files into `adfs_pdf_process`; `PdfQueueWorker` runs `process()` on cron.
- Batch: route `.batch` (`PdfBatchForm`).
- Per file: entity operations expose PDF Info, Processar, Editar, Mesclar. `PdfEditForm` dispatches to the derivative ops.
- Diff: `.pdf_diff` (`PdfDiffController`) rasterises both PDFs with gs and shows a per-page image comparison.
- Dashboard: `.dashboard` (`getStats()`), `/clean` removes old derivatives, `/reprocess` re-runs failed jobs.
