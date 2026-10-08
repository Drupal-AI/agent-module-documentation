<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Presentation Processor — install, config, routes

## Install / enable
`drush en advanced_filesystem_presentation_processor`. Requires `file`, `media`, `advanced_filesystem`. Install creates one table, `adfs_presentation_jobs` (`advanced_filesystem_presentation_processor.install`). Slide-text/notes/metadata extraction needs only `ext-zip`; PDF conversion needs `soffice`; the per-slide image gallery additionally needs `gs`.

## Config object: `advanced_filesystem_presentation_processor.settings`
Defined in `config/install/…settings.yml`, typed in `config/schema/…schema.yml`. Read via `PresentationProcessorService::config()`.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `soffice_bin` | string | `/usr/bin/soffice` | LibreOffice binary for PPTX→PDF. |
| `gs_bin` | string | `/usr/bin/gs` | Ghostscript for PDF→per-slide images. |
| `extract_text` | bool | `true` | Extract slide text. |
| `extract_notes` | bool | `true` | Extract speaker notes. |
| `convert_to_pdf` | bool | `false` | Auto-convert to PDF during `process()`. |
| `generate_slide_images` | bool | `false` | Render per-slide images (requires PDF first). |
| `slide_image_format` | string | `jpg` | `jpg` (jpeg device) or `png` (png16m device). |
| `slide_image_width` | int | `1280` | Slide image width in px. |
| `auto_process` | bool | `false` | Queue PPTX uploads on `hook_file_insert`. |
| `max_file_size_mb` | int | `100` | Files larger than this are skipped (`0` = unlimited). |
| `output_dir` | string | `private://adfs_presentation_output` | Base dir for `/pdf` and `/slides/{fid}` outputs. |

Settings form: `Form\PresentationSettingsForm` at route `.settings`.

## Routes & permissions
All six routes in `advanced_filesystem_presentation_processor.routing.yml` require `_permission: 'administer advanced_filesystem_presentation_processor'` (declared `restrict access: true`) and are `_admin_route`s: `.settings`, `.dashboard`, `.batch`, `.file_view` (`/…/{file}/presentation`), `.slide_gallery` (`/…/{file}/presentation/slides`), `.file_process` (`/…/{file}/presentation/process`). Per-file routes take an `entity:file` `{file}` (`file: \d+`). No anonymous / `_access: TRUE` routes. The `process advanced_filesystem_presentation_processor` permission is declared but shipped routes gate on `administer …`.

Private output dirs (`adfs_presentation_output`, `adfs_presentation_derivatives`, `adfs_presentation_page_thumbs`) are served only to holders of `administer advanced_filesystem_presentation_processor` via `hook_file_download`; others get `-1`.

## Operating it
- Automatic: enable `auto_process`; `hook_file_insert` enqueues PPTX-mime files into `adfs_presentation_process`; `PresentationQueueWorker` runs `process()` on cron.
- Batch: route `.batch` (`PresentationBatchForm`).
- Per file: entity operations expose Presentation Info and Processar; `PresentationFileProcessForm` runs the pipeline; `.slide_gallery` shows the rendered slides.
- Dashboard: `.dashboard` (`PresentationDashboardController::dashboard`) shows `getStats()` coverage.
