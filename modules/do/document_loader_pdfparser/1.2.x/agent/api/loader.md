<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The PDF Parser loader plugin & API

## Install & enable

```bash
composer require drupal/document_loader_pdfparser
drush en document_loader_pdfparser -y
```

Composer pulls the three required PHP libraries (`smalot/pdfparser ^2.12`,
`ahmaadkhader/pdf-to-html ^1.0`, `league/html-to-markdown ^5.1`) and `drupal/document_loader ^2.0`.
This module ships **no permissions, no routes, no config objects, no config schema, no
`services.yml` and no Drush commands** — it only registers one plugin with the Document Loader
framework. After enabling, it appears automatically at
`/admin/config/media/document-loader` (the framework's settings form, id
`document_loader.settings_form`, the module's `configure` link).

## The plugin

`src/Plugin/DocumentLoader/PdfParserLoader.php` — `final class PdfParserLoader extends
DocumentLoaderBase`. Discovered via the PHP attribute (no plugin YAML):

```php
#[DocumentLoader(
  id: 'document_loader_pdfparser.pdfparser',
  label: new TranslatableMarkup('PDF Parser'),
  description: new TranslatableMarkup('Parses a PDF using the local PDF Parser library.'),
  document_loader_types: ['document_loader_type:pdf'],
  output_types: ['text', 'html', 'markdown'],
)]
```

- **Input type:** `document_loader_type:pdf` — defined by `document_loader`, not this module. Its
  value object is `Drupal\document_loader\DocumentLoaderType\Input\PdfInput` (extends `FileInput`,
  `getSupportedExtensions() = ['pdf']`). `PdfInput::getContent()` returns the file **URI/path**;
  `getOptions()` returns the loader options array.
- **Output types:** `text` (default), `html`, `markdown`.

### `load(DocumentLoaderInputInterface $input, string $output_format = 'text'): DocumentLoaderOutputInterface`

1. If `$input` is not a `PdfInput`, throws `\InvalidArgumentException`.
2. `$fileUri = $input->getContent();` then `@$contents = file_get_contents($fileUri);` — the `@`
   suppresses PHP warnings; an empty/`FALSE` result throws
   `Drupal\document_loader\Exception\DocumentLoaderException` ("Failed to load the provided PDF
   file.").
3. `new \Smalot\PdfParser\Parser()` → `$pdf = $parser->parseContent($contents);`. Any thrown
   `\Exception` is caught and re-thrown as `DocumentLoaderValidationException` ("Failed to parse
   the given PDF file.").
4. `$metadata = $pdf->getDetails();` — page count, author, title, subject, keywords, dates, etc.
5. Loader options are read with `$this->extractOwnOptions($input->getOptions())` (base-class helper
   that strips the framework's per-plugin option prefix).
6. Returns via `match ($output_format)`:
   - `text` → `new TextOutput($pdf->getText(), $metadata)`
   - `html` → `new HtmlOutput($this->extractHtml($contents, ['native_headings' => !empty($options['native_headings'])]), $metadata)`
   - `markdown` → `new MarkdownOutput($this->convertToMarkdown($this->extractHtml($contents, ['native_headings' => TRUE])), $metadata)`
   - anything else → `DocumentLoaderException` ("Unsupported output format…").

## Loader options

`getLoaderOptionsSchema()` declares exactly one option:

| Key | Type | Default | Effect |
|---|---|---|---|
| `native_headings` | boolean | `FALSE` | Render detected headings as native `h1`–`h6` tags in **HTML** output instead of styled paragraphs. |

Notes:

- The option is only honoured for the **`html`** output. For **`markdown`** the plugin always
  passes `native_headings => TRUE` internally (so headings survive the HTML→Markdown conversion);
  for **`text`** it is irrelevant.
- Options are supplied on the `PdfInput` constructor's second argument and scoped/stripped by
  `DocumentLoaderBase::extractOwnOptions()`.

## How HTML and Markdown are produced

- `extractHtml(string $contents, array $options): string` — `ahmaadkhader/pdf-to-html`'s
  `PdfToHtml` reads from a **file path**, so the raw bytes are written to a `tempnam(sys_get_temp_dir(),
  'document_loader_pdfparser')` file, converted with `$converter->extractHtml($tempFile, $options)`,
  and the temp file is removed in a `finally { unlink($tempFile); }`. Failure to create/write the
  temp file throws `DocumentLoaderException`.
- `convertToMarkdown(string $html): string` — returns `''` for blank input; otherwise uses
  `League\HTMLToMarkdown\HtmlConverter(['header_style' => 'atx', 'strip_tags' => TRUE])` and
  `trim()`s the result.

## Programmatic usage

```php
use Drupal\document_loader\DocumentLoaderType\Input\PdfInput;

$loader = \Drupal::service('plugin.manager.document_loader')
  ->createInstance('document_loader_pdfparser.pdfparser');

// Plain text (+ metadata).
$output = $loader->load(new PdfInput('public://docs/report.pdf'));
$text     = $output->getContent();
$metadata = $output->getMetadata();   // getDetails(): pages, author, title, …

// Semantic HTML with native headings.
$html = $loader
  ->load(new PdfInput('public://docs/report.pdf', ['native_headings' => TRUE]), 'html')
  ->getContent();

// Markdown.
$md = $loader->load(new PdfInput('public://docs/report.pdf'), 'markdown')->getContent();
```

Prefer routing through the framework — `document_loader.manager`
(`DocumentLoaderManager::loadFromData()` / `loadFromInput()`) — when you want its input
normalisation (file-entity IDs, stream URIs, remote-URL download), access checks and pre/post-load
hooks to run before this plugin. Calling the plugin directly bypasses that layer, so hand it a URI
you already trust.

## Errors

All from `Drupal\document_loader\Exception\*`:

- `\InvalidArgumentException` — `$input` is not a `PdfInput`.
- `DocumentLoaderException` — bytes could not be read, temp file could not be created/written, or
  an unsupported `$output_format` was requested.
- `DocumentLoaderValidationException` — `smalot/pdfparser` could not parse the content.

## Testing

`tests/src/Unit/Plugin/DocumentLoader/PdfParserLoaderTest.php` (unit test, group
`document_loader_pdfparser`) parses a bundled `minimal-document.pdf` and asserts `TextOutput`,
`HtmlOutput` and `MarkdownOutput` each contain the expected text, plus that an unsupported format
and a non-`PdfInput` input and a missing file all throw.
