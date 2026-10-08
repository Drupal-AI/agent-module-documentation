<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PresentationProcessorService — method reference

Service id `advanced_filesystem_presentation_processor.service`, class `Drupal\advanced_filesystem_presentation_processor\Service\PresentationProcessorService`. Constructor args: `config.factory`, `database`, `file_system`, `logger.factory`. Operations take a `Drupal\file\FileInterface`; external commands run via `exec()` with every path/argument passed through `escapeshellarg`.

## Status / pipeline
- `getSystemStatus(): array` — availability of soffice, gs, ZipArchive.
- `process(FileInterface): array` — size-gate (`max_file_size_mb`), `extractPptx()`, optional `convertToPdf()`, optional `generateSlideImages()` (only if a PDF was produced), then `upsertJob()`.

## Pure-PHP PPTX extraction (ZipArchive, no external tool)
- `extractPptx(string $realPath): ?array` — iterates `ppt/slides/slideN.xml` (N up to 500, stops at first missing), `ppt/notesSlides/notesSlideN.xml`, and `docProps/core.xml`. Returns `{text, notes, slide_count, meta}`. Text is `strip_tags` of the slide XML with `</a:p>`/`</a:r>` turned into newlines (`extractXmlText`).

## External conversion
- `convertToPdf(FileInterface, string $realPath): ?string` — `soffice --headless --convert-to pdf --impress` with a per-file temp `HOME`. Returns the PDF URI under `output_dir/pdf` or NULL (fail-soft).
- `generateSlideImages(FileInterface, string $pdfRealPath): array` — `gs` renders the PDF to `slide_%04d.{jpg|png}` under `output_dir/slides/{fid}` at `-r144`, width `slide_image_width`. Returns `[slides_dir_uri, first_slide_thumb_uri]`.

## Persistence / rendering
- `getJob(int $fid)`, `upsertJob(array)`, `getStats()`, `getSlideImages(int $fid)` (globs the slides dir).
- All DB access uses the parameterized Drupal DB API; the single table is `adfs_presentation_jobs`.
- `PresentationFileViewController::view` escapes extracted slide text with `htmlspecialchars` inside a `<pre>` `#markup`; the thumbnail is emitted as an `<img>` from a `file_url_generator` URL. Extracted text is not rendered raw.
