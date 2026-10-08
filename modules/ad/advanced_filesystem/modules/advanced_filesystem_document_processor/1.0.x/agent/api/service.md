<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DocumentProcessorService — method reference

Service id `advanced_filesystem_document_processor.service`, class `Drupal\advanced_filesystem_document_processor\Service\DocumentProcessorService`. Constructor args: `config.factory`, `database`, `file_system`, `logger.factory`. All operations take a `Drupal\file\FileInterface`.

## Status / pipeline
- `getSystemStatus(): array` — availability of soffice, ZipArchive, SimpleXML.
- `process(FileInterface): array` — main pipeline: size-gate (`max_file_size_mb`), `extractDocx()`, PII detect, optional `convertToPdf()` / `stripMetadata()`, then `upsertJob()`. Returns the job row.

## Pure-PHP DOCX read (ZipArchive, no external tool)
- `extractDocx(string $realPath): ?array` — `{text, meta}` from `word/document.xml`, `docProps/core.xml`, `docProps/app.xml`.
- `detectPii(string $text): bool` — regex for CPF/CNPJ/e-mail/16-digit card.
- `extractDocxImages(FileInterface): array` — writes `word/media/*` to `private://adfs_document_derivatives/{fid}_images`.
- `generateToc(FileInterface): array` — headings from `w:pStyle` → JSON derivative.
- `validateLinks(FileInterface): array` — parses `word/_rels/document.xml.rels`, issues HEAD requests (`get_headers`) to each `http(s)` target, writes a `_links.json` report.
- `diffDocuments(FileInterface $a, FileInterface $b): array` — LCS word diff → escaped HTML report.

## Pure-PHP DOCX write (copy + ZipArchive rewrite)
- `stripMetadata()`, `fillTemplate(FileInterface, array $variables)`, `bulkReplace(FileInterface, array $replacements)`, `acceptTrackChanges()`, `updateMetadata(FileInterface, array $fields)` — each copies the file into a private derivative dir and rewrites `word/document.xml` or `docProps/core.xml`. Values are `htmlspecialchars(..., ENT_XML1)`-escaped before insertion.

## LibreOffice (soffice) conversion
- `convertToPdf(FileInterface, string $realPath): ?string`, `convertToHtml()`, `convertToOdt()` — run `soffice --headless --convert-to …` with a per-file temp `HOME`. All arguments passed through `escapeshellarg`. Return the derivative URI or NULL on failure (fail-soft: NULL/`failed` row, logged; the pipeline continues).

## Ghostscript (gs) PDF operations
- `ensurePdfPath(FileInterface): ?string` — returns/creates a PDF rendering, caching `pdf_uri` on the job.
- `mergeDocuments(FileInterface, array $others)`, `signPdf(FileInterface, string $signerName, string $reason)`, `extractPageRange(FileInterface, int $start, int $end)`, `keepPages(FileInterface, array $pages)`, `removePages(FileInterface, array)`, `addPassword(FileInterface, string $userPw, string $ownerPw, bool $print, bool $copy)`, `generatePageThumbnails(FileInterface, int $maxPages)`.

## Persistence
- `getJob(int $fid)`, `upsertJob(array)`, `getStats()`, `getDerivatives(int $fid)`, `getPageThumbs(int $fid)`.
- `saveDerivative()` / `derivativeError()` insert into `adfs_document_derivatives` and return a status array. All DB access uses the parameterized Drupal DB API.

## Rendering note
`DocumentFileViewController::view` escapes extracted text with `htmlspecialchars` + `nl2br` before `#markup`; the diff/report HTML escapes document text with `htmlspecialchars`. Extracted document text is not rendered raw.
