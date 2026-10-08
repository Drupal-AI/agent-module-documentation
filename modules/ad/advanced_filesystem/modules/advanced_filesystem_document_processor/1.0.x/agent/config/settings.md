<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Processor — install, config, routes

## Install / enable
`drush en advanced_filesystem_document_processor`. Requires `file`, `media`, `advanced_filesystem`. Install creates `adfs_document_jobs`, `adfs_document_derivatives`, `adfs_document_page_thumbs` (`advanced_filesystem_document_processor.install`, `_schema()` + `update_8001`). Conversion features need the `soffice`/`gs` binaries on the server PATH (or configured absolute paths); pure-PHP extraction needs only `ext-zip`.

## Config object: `advanced_filesystem_document_processor.settings`
Defined in `config/install/…settings.yml`, typed in `config/schema/…schema.yml`. Read via `DocumentProcessorService::config()`.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `soffice_bin` | string | `/usr/bin/soffice` | LibreOffice binary for PDF/HTML/ODT conversion. |
| `extract_text` | bool | `true` | Extract plain text from DOCX. |
| `convert_to_pdf` | bool | `false` | Auto-convert to PDF during `process()`. |
| `strip_metadata` | bool | `false` | Auto-strip hidden metadata during `process()`. |
| `detect_pii` | bool | `true` | Run PII regex over extracted text. |
| `auto_process` | bool | `false` | Queue Word uploads on `hook_file_insert`. |
| `max_file_size_mb` | int | `50` | Files larger than this are skipped (`0` = unlimited). |
| `output_dir` | string | `private://adfs_document_output` | Base dir for pdf/html/odt/clean/filled outputs. |

The `gs_bin` path is read by PDF operations (`convertToPdf`/`mergeDocuments`/`signPdf`/page ops) with a `/usr/bin/gs` fallback even though it is not in the shipped install file — set it in the active config if Ghostscript lives elsewhere.

Settings form: `Form\DocumentSettingsForm` at route `.settings`.

## Routes & permissions
Every route in `advanced_filesystem_document_processor.routing.yml` requires `_permission: 'administer advanced_filesystem_document_processor'` (declared `restrict access: true` in `.permissions.yml`) and is an `_admin_route`. There are no anonymous or `_access: TRUE` routes. Per-file forms/controllers take an `entity:file` `{file}` parameter (`file: \d+`). The second permission, `process advanced_filesystem_document_processor`, is declared but the shipped routes/hooks gate on `administer …` instead.

Private derivative directories (`adfs_document_output`, `adfs_document_derivatives`, `adfs_document_page_thumbs`) are served only to holders of `administer advanced_filesystem_document_processor` via `hook_file_download`; other users get `-1` (deny).

## Operating it
- Automatic: enable `auto_process`; `hook_file_insert` enqueues Word-mime files into queue `adfs_document_process`; `DocumentQueueWorker` calls `DocumentProcessorService::process()` on cron.
- Batch: route `.batch` (`DocumentBatchForm`) processes existing files.
- Per file: the file's entity operations expose Document Info, Processar, Editar, Comparar, Mesclar. `DocumentEditForm` dispatches to the service ops (extract images, bulk replace, convert, validate links, TOC, accept changes, sign).
- Dashboard: `.dashboard` shows `getStats()` coverage; `/clean` removes old derivatives; `/reprocess` re-runs failed jobs.
