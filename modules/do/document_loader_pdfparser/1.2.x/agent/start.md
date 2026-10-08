<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader: PDF Parser (document_loader_pdfparser) — agent index

A single `DocumentLoader` plugin for the **`document_loader`** framework that extracts content
from PDF files. Text comes from **`smalot/pdfparser`**, semantic HTML from
**`ahmaadkhader/pdf-to-html`**, and Markdown from that HTML via **`league/html-to-markdown`**.
PDF metadata (page count, author, title, …) rides along with every output. The plugin holds no
PDF logic beyond wiring these libraries together.

- Package `Web services`. Core `^10.4 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.2.x
  (installed 1.2.0). Security advisory: **covered**.
- Depends on `document_loader:document_loader (^2.0)` plus the three Composer PHP libraries above.
- **No routes, no permissions, no config objects, no config schema, no admin form, no Drush,
  no `services.yml`.** It only registers one plugin with the framework.
- `configure` points at the framework form `document_loader.settings_form`
  (`/admin/config/media/document-loader`), where the plugin shows up automatically once enabled.

## Solution docs

- **The loader plugin, its attribute, output formats, the `native_headings` option, the library
  wiring, and programmatic use** → [api/loader.md](api/loader.md)

## What it actually provides (from source)

- `DocumentLoader` plugin **`document_loader_pdfparser.pdfparser`** —
  `src/Plugin/DocumentLoader/PdfParserLoader.php`, `final class PdfParserLoader extends
  DocumentLoaderBase`. Attribute `#[DocumentLoader(...)]`:
  `document_loader_types: ['document_loader_type:pdf']`,
  `output_types: ['text', 'html', 'markdown']`, label *"PDF Parser"*.
- `load(DocumentLoaderInputInterface $input, string $output_format = 'text')`:
  1. rejects any `$input` that is not a `PdfInput` (`\InvalidArgumentException`);
  2. reads the file URI with `$input->getContent()` and loads bytes with
     `@file_get_contents($fileUri)` (throws `DocumentLoaderException` on empty/false);
  3. parses with `new \Smalot\PdfParser\Parser()` → `parseContent($contents)` (parse failure →
     `DocumentLoaderValidationException`);
  4. grabs `$pdf->getDetails()` as metadata;
  5. `match ($output_format)` → `TextOutput` (`$pdf->getText()`), `HtmlOutput`
     (`extractHtml()`), `MarkdownOutput` (`convertToMarkdown(extractHtml(...))`), else
     `DocumentLoaderException`.
- `getLoaderOptionsSchema()` declares one loader option: **`native_headings`** (boolean, default
  `FALSE`) — render detected headings as native `h1`–`h6` in HTML instead of styled paragraphs.
- Helpers: `extractHtml()` writes the bytes to a `tempnam()` file, runs `PdfToHtml::extractHtml()`,
  and always `unlink()`s the temp file in a `finally`; `convertToMarkdown()` uses `HtmlConverter`
  (`header_style => atx`, `strip_tags => TRUE`).

## Notes

- The `pdf` **input type** (`document_loader_type:pdf`) and the `PdfInput`/`FileInput` value
  objects are defined by the **`document_loader`** module, not here. This module only adds the
  loader that handles that type.
- Markdown output always requests `native_headings => TRUE` internally; the `native_headings`
  option only affects the `html` output format.
- All work is local PHP — the module makes no HTTP calls of its own. Remote-URL and file-entity
  resolution, access checks, and size caps are handled upstream by the framework before `load()`
  runs.
- Covered by a PHPUnit unit test (`tests/src/Unit/.../PdfParserLoaderTest.php`) exercising text,
  html and markdown output, unsupported-format and wrong-input-type errors, and a missing file.
