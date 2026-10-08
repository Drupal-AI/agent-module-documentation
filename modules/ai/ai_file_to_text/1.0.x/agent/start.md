<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI File to Text (ai_file_to_text) — agent index

Converts an uploaded document file into plain **text, HTML, Markdown, or a structured JSON DOM tree**.
The module owns **no HTTP client and makes no AI-provider call itself** — it is a pure-PHP extraction
layer. It ships seven extractors (Word, ODT, spreadsheet/CSV, PDF pure-PHP, PDF via poppler, plain
text, Markdown) as tagged services, a `FileExtractorManager` that maps file extension → extractor,
and one `document_loader:file` plugin that every consumer routes through. Three consumers sit on top:
two **AI Automator** plugins (`file_to_text_text_long`, `file_to_text_string_long`) that fill a
`text_long`/`string_long` field from a file field on entity save, one **AI Agent function call**
(`file_to_text`, group `information_tools`) that an agent calls with a file id or file location, and
the **Document Loader** plugin any code can call directly. Supported extensions (10 across 7
extractors): `docx doc odt xlsx xls ods csv pdf txt md`.

- Depends on (info.yml, hard): `document_loader:document_loader`. **Undeclared soft deps:** the
  function-call plugin needs the `ai` module (`FunctionCallBase`); the two automator plugins need
  `ai_automators` (`ExternalBase`/`AiAutomatorType`). Neither is in `dependencies:`.
- Core: `^10.3 || ^11`. Package: `AI Tools`. Version `1.0.0`.
- Composer libs: `phpoffice/phpword ^1.4`, `phpoffice/phpspreadsheet ^2.0`,
  `ahmaadkhader/pdf-to-html ^1.0`, `league/commonmark ^2.0`, `league/html-to-markdown ^5.1`.
  Optional system package `poppler-utils` (`pdftotext`/`pdftohtml`) enables `PopplerPdfExtractor`.
- **No settings page / `configure` route. No permissions. No drush. No config schema.** Options are
  per-automator or per-function-call, not global.
- Defines **no Drupal plugin type** — extractors are plain tagged services (`ai_file_to_text.extractor`)
  collected by a manager, not a `DefaultPluginManager`.
- Operational note (generic): the parsers are third-party libraries handling uploaded files — keep
  them patched; and extracted content handed onward to a hosted model leaves the site.

## What you'd do → where

- **Extract from code / add support for a new file type / call the Document Loader programmatically** →
  [api/extractors.md](api/extractors.md)
- **Use the automators, the `file_to_text` agent function, or the `document_loader:file` plugin** →
  [plugins/index.md](plugins/index.md)
- **Where are the settings? / output-format + heading options / install poppler** →
  [configure/index.md](configure/index.md)

## Key facts (real machine names)

- Document Loader plugin: `document_loader:file` (`Plugin/DocumentLoader/FileDocumentLoader`).
  Declared `output_types: [text, html, markdown, json]`; declared `document_loader_types:
  [pdf, word, spreadsheet, text, markdown, xml]` (each prefixed `document_loader_type:`). Types and
  output are re-synced at runtime by the alter hook (definition may split to `document_loader:file__1`
  when extractors differ in capability).
- AI Agent function call: id `ai_file_to_text:file_to_text`, `function_name: file_to_text`, group
  `information_tools` (`Plugin/AiFunctionCall/FileToText`). Params: `file_id`, `file_location`,
  `output_format` (default `text`).
- AI Automator plugins: `file_to_text_text_long` (`field_rule: text_long`, class `FileToText`),
  `file_to_text_string_long` (`field_rule: string_long`, class `FileToString`); shared base
  `FileToTextBase`. Form keys: `automator_output_format`, `automator_native_headings`.
- Manager service: `Drupal\ai_file_to_text\Extractor\FileExtractorManager`
  (arg `!tagged_iterator ai_file_to_text.extractor`). Not a route/plugin manager.
- Extractor services (tag `ai_file_to_text.extractor`): `TxtExtractor` (`txt`), `WordExtractor`
  (`docx`,`doc`), `OdtExtractor` (`odt`), `SpreadsheetExtractor` (`xlsx`,`xls`,`ods`,`csv`),
  `PdfExtractor` (`pdf`, pure PHP), `PopplerPdfExtractor` (`pdf`, needs poppler), `MdExtractor` (`md`).
- Extension API: `ExtractorInterface`, abstract `FileExtractor`, `HtmlToJsonTrait`.
  `document_loader_type` strings: `…:word` (docx/doc/odt), `…:spreadsheet`, `…:pdf`, `…:text`,
  `…:markdown`.
- Hook: `Drupal\ai_file_to_text\Hook\DocumentLoaderInfoAlter` (OOP `#[Hook('document_loader_info_alter')]`);
  legacy `ai_file_to_text_document_loader_info_alter()` in `.module`.
- Output formats: `text` (default), `html`, `markdown` (HTML→league/html-to-markdown), `json`
  (spreadsheets native tabular; others HTML→DOM tree via `HtmlToJsonTrait`).
