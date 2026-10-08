# Extractor architecture & extension API

The extraction engine is a set of plain services, not a Drupal plugin type. Any module can add a file
type by registering one more tagged service — no change to `ai_file_to_text`.

## Manager — `FileExtractorManager`

Service `Drupal\ai_file_to_text\Extractor\FileExtractorManager`, constructed from
`!tagged_iterator ai_file_to_text.extractor`. At construction it skips extractors whose
`isAvailable()` is FALSE, builds an **extension → extractor** map, and aggregates document-loader
types and per-type/per-extension output formats.

Key methods:
- `extract(string $file_path, string $extension, string $format = 'text', array $options = []): ?string`
  — the dispatch entry point (`FileExtractorManager.php:318`). `NULL` if the extension is unsupported;
  falls back to `text` if the extractor cannot produce the requested format. For `markdown` it forces
  `native_headings = TRUE`, generates HTML, then `htmlToMarkdown()`. For `json` it uses the extractor's
  native `extractJson()` when the extractor lists `json`, else HTML→`htmlToJsonTree()`.
- `isSupported($ext)`, `getSupportedExtensions()`, `getOutputFormatsForExtension($ext)`,
  `isOutputFormatSupported($ext, $format)`.
- `getDocumentLoaderTypes()`, `getOutputFormats()`, `getOutputFormatsForType($type)`,
  `getCapabilityGroups()` — consumed by the `document_loader_info_alter` hook.
- `htmlToMarkdown($html)` — delegates to the captured `MdExtractor`.

Markdown and JSON are **derived** formats: an extractor that lists `html` in
`getSupportedOutputFormats()` automatically gains `markdown` and `json`. `text` must always be present.

## `ExtractorInterface`

Every extractor implements `Drupal\ai_file_to_text\Extractor\ExtractorInterface`:

```php
public function isAvailable(): bool;                 // e.g. required lib/binary present
public function getDocumentLoaderType(): string;     // 'document_loader_type:pdf' etc.
public function getSupportedOutputFormats(): array;  // ['text'] or ['text','html'] (+'json' if native)
public function getSupportedExtensions(): array;     // lowercase, no dot: ['pptx']
public function extractText(string $file_path, string $extension = ''): string;
public function extractHtml(string $file_path, string $extension = '', array $options = []): string;
public function extractJson(string $file_path, string $extension = '', array $options = []): string;
```

`file_path` is a **real filesystem path** (already `realpath()`-resolved by the loader), not a stream
URI. `$options['native_headings']` (bool) controls whether H1 is a native `<h1>` or `<p class="h1">`.

Abstract base `FileExtractor` provides a default `extractJson()` (HTML→DOM tree, else text-wrapped)
and `readFileContents()` (existence/read check). Trait `HtmlToJsonTrait` provides
`htmlToJsonTree($html)` — parses HTML via `DOMDocument` and returns nodes shaped as
`{"tag": "...", "attributes": {...}, "children": [...]}`, text nodes as trimmed strings.

## Built-in extractors

| Class | Extensions | `document_loader_type:` | Native output | Engine |
|---|---|---|---|---|
| `TxtExtractor` | `txt` | `text` | text, html | direct read; HTML is `htmlspecialchars`-escaped paragraphs |
| `MdExtractor` | `md` | `markdown` | text, html | league/commonmark (`html_input=strip`, `allow_unsafe_links=FALSE`); also owns `htmlToMarkdown()` |
| `WordExtractor` | `docx`, `doc` | `word` | text, html | phpoffice/phpword (`READER_MAP`: docx→Word2007, doc→MsDoc) |
| `OdtExtractor` | `odt` | `word` | text, html | `ZipArchive` + `DOMDocument`/`DOMXPath` over `content.xml`/`styles.xml` |
| `SpreadsheetExtractor` | `xlsx`,`xls`,`ods`,`csv` | `spreadsheet` | text, html, **json** (native tabular) | phpoffice/phpspreadsheet |
| `PdfExtractor` | `pdf` | `pdf` | text, html | `ahmaadkhader/pdf-to-html` (pure PHP), always available |
| `PopplerPdfExtractor` | `pdf` | `pdf` | text, html, json | `pdftotext`/`pdftohtml` via `shell_exec`; `isAvailable()` = binaries on `PATH`; file path is `escapeshellarg`-escaped |

## Add a custom extractor

```php
// your_module/src/Extractor/PptxExtractor.php
namespace Drupal\your_module\Extractor;

use Drupal\ai_file_to_text\Extractor\FileExtractor;   // gives default extractJson()

class PptxExtractor extends FileExtractor {
  public function isAvailable(): bool { return TRUE; }
  public function getDocumentLoaderType(): string { return 'document_loader_type:presentation'; }
  public function getSupportedOutputFormats(): array { return ['text']; } // must include 'text'
  public function getSupportedExtensions(): array { return ['pptx']; }
  public function extractText(string $file_path, string $extension = ''): string { /* … */ }
  public function extractHtml(string $file_path, string $extension = '', array $options = []): string { return ''; }
}
```

```yaml
# your_module.services.yml
services:
  your_module.extractor.pptx:
    class: Drupal\your_module\Extractor\PptxExtractor
    tags:
      - { name: ai_file_to_text.extractor }
```

Clear caches. `FileExtractorManager` discovers the tag, adds the extension, and the alter hook
registers the new `document_loader_type` so `getLoaderByType()` finds `document_loader:file` for it.
When capabilities differ from the built-ins, the plugin definition auto-splits (`document_loader:file__1`).
