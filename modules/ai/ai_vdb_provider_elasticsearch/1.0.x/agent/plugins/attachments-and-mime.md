<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF extractor & text-MIME registrar (optional indexing helpers)

Two small pieces that help feed document text into the index. Neither is required for vector search itself.

## PDF text extractor — `PhpPdfParserExtractor`

`src/Plugin/search_api_attachments/PhpPdfParserExtractor.php`, a Search API Attachments text-extractor
plugin (`@SearchApiAttachmentsTextExtractor id="php_pdfparser_extractor"`, label *"PHP PdfParser
(smalot/pdfparser)"*), extending `TextExtractorPluginBase`.

- **Only active when `search_api_attachments` is also enabled** (the plugin namespace comes from that
  module; it is a dev/optional dependency — `composer suggest`). Select it at
  `/admin/config/search/search_api_attachments` under *Extraction method*.
- `extract(File $file)` returns `NULL` unless the file's MIME type is a PDF type; otherwise it resolves the
  file's real path (`getRealpath($file->getFileUri())`), runs `Smalot\PdfParser\Parser::parseFile()`, and
  returns `$pdf->getText()`. Pure PHP — **no external binary** (unlike Tika/pdftotext extractors).
- Needs the `smalot/pdfparser` vendor library (surfaced by `hook_requirements()` as a warning if missing).

## Text-document MIME registrar — `TextDocumentMimeTypeRegistrar`

`src/EventSubscriber/TextDocumentMimeTypeRegistrar.php`, service
`ai_vdb_provider_elasticsearch.text_document_mime_registrar`, tagged `event_subscriber`.

- Subscribes to core's `MimeTypeMapLoadedEvent`. In `onLoaded()` it adds extension→MIME mappings so
  text-based document formats are recognized as `text/*` and can be read directly by Search API Attachments'
  "read text files directly" path (`file_get_contents`) instead of being routed to the PDF-only extractor.
- Mappings (`MAPPINGS` constant): `md`/`markdown`→`text/markdown`, `rst`→`text/x-rst`, `org`→`text/x-org`,
  `adoc`/`asciidoc`→`text/x-asciidoc`, `log`→`text/plain`, `yaml`/`yml`→`text/yaml`, `ini`/`conf`→
  `text/plain`, `toml`→`text/x-toml`. Core's existing `txt`/`csv`/`json`/`xml`/`html`/… mappings are not
  duplicated.
- Effect: an out-of-the-box site indexes Markdown, YAML, AsciiDoc, Org, RST, TOML and log/conf files as text
  alongside PDFs, instead of them arriving as `application/octet-stream` and silently producing no content.

Both are indexing-pipeline conveniences; the vector storage/search itself is handled by
[vdb-provider.md](vdb-provider.md).
