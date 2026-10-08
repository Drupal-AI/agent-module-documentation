<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PdfProcessorService — method reference

Service id `advanced_filesystem_pdf_processor.service`, class `Drupal\advanced_filesystem_pdf_processor\Service\PdfProcessorService`. Constructor args: `config.factory`, `database`, `file_system`, `logger.factory`. Operations take a `Drupal\file\FileInterface`; each external command runs via `exec()` with every path/argument passed through `escapeshellarg`.

## Status / pipeline
- `getSystemStatus(): array` — `is_executable` state of pdftotext, pdfinfo, gs, convert.
- `process(FileInterface): array` — size-gate (`max_file_size_mb`), `extractMetadata()` (pdfinfo), optional `extractText()` (pdftotext) + scanned/PII flags, optional `generateThumbnail()`, optional `exportToPdfA()`, then `upsertJob()`.

## Extraction
- `extractText(string $realPath): ?string` — `pdftotext -layout` into a tempfile, read back, unlink.
- `extractMetadata(string $realPath): ?array` — parse `pdfinfo` key/value lines.
- `detectPii(string $text): bool` — CPF/CNPJ/e-mail/BR-phone/card regex.

## Ghostscript derivatives (tracked in `adfs_pdf_derivatives`)
- `generateThumbnail()`, `exportToPdfA()`, `convertToPdfaDerivative(FileInterface, int $standard)`.
- `splitPages(FileInterface, int $start, int $end)`, `extractPageRange(...)`, `keepPages(FileInterface, array)`, `removePages(FileInterface, array)`, `splitIntoChunks(FileInterface, int $parts)`.
- `mergePdfs(FileInterface $primary, array $others, string $outputName)` — output name slugified with `preg_replace('/[^a-z0-9_-]/','_')`.
- `rotatePages(FileInterface, array $pages, int $degrees)` — `degrees` validated to {90,180,270}.
- `resizePages(FileInterface, string $pageSize)` — allow-listed A4/A3/Letter/Legal → fixed `-dDEVICEWIDTHPOINTS/HEIGHTPOINTS`.
- `compressPdf(FileInterface, string $level)` — `level` allow-listed to screen/ebook/printer/prepress/default.
- `addTextWatermark(FileInterface, string $text, string $position, int $fontSize)` — writes a temp PostScript program (paren/backslash-escaped text) consumed by gs.
- `addPassword(FileInterface, string $userPw, string $ownerPw, bool $print, bool $copy)`, `removePassword(FileInterface, string $currentPassword)`.
- `generatePageThumbnails(FileInterface, int $maxPages)` → `adfs_pdf_page_thumbs`.

## Other external tools
- `ocrFile(FileInterface): array` — gs rasterises up to 30 pages to PNG, `tesseract` OCRs each, concatenates to a `.txt` derivative.
- `extractPdfImages(FileInterface): array` — `pdfimages -png` into a private dir; returns first image URI.

## Persistence / rendering
- `getJob`, `upsertJob`, `getStats`, `getDerivatives`, `getPageThumbs`, `saveDerivative`/`derivativeError` — parameterized Drupal DB API only.
- `PdfFileViewController::view` escapes extracted text with `htmlspecialchars` inside a `<pre>` `#markup`; `PdfDiffController` builds option/label markup with `htmlspecialchars`. Extracted PDF text is not rendered raw.
