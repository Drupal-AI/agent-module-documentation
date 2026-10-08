<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI File to Text converts uploaded Word, ODT, spreadsheet, CSV, PDF, plain-text and Markdown files into plain text, HTML, Markdown, or structured JSON, and exposes that conversion as AI Automators, an AI Agent function call, and a Document Loader plugin.

---

Install with `composer require drupal/ai_file_to_text` and `drush en ai_file_to_text`; Composer pulls the parsing libraries (PHPWord, PhpSpreadsheet, a PDF-to-HTML engine, and the CommonMark / html-to-markdown libraries) and the required **Document Loader** module. There is **no settings page** — enabling the module is all the setup it needs, and every option is chosen at the point of use. To fill a field from an uploaded document, enable **AI Automators**, add a file field plus a `text_long` or `string_long` target field to your content type, and configure the **File to Text** automator on the target field: pick the source file field and an **output format** (Plain Text, HTML, Markdown, or JSON); for HTML you can also toggle **Use class-based heading 1** so H1 renders as `<p class="h1">`. On entity save the file is extracted automatically into the target field. To let an AI agent read documents, enable the **`ai`** module and add the **`file_to_text`** function call to your agent — it accepts a Drupal `file_id` or a `file_location`, plus an optional `output_format`. From custom code, call the `document_loader:file` plugin directly through the `document_loader.type_factory` and `plugin.manager.document_loader` services. For higher-quality PDF output, install the optional `poppler-utils` system package. Ten extensions are supported out of the box — `docx doc odt xlsx xls ods csv pdf txt md` — and other modules can register new extractors as tagged services without patching this module.

---

- Extract plain text from an uploaded PDF.
- Convert a Word `.docx` or `.doc` file to HTML.
- Turn an ODT document into Markdown.
- Read a spreadsheet (`.xlsx`, `.xls`, `.ods`) or CSV into text.
- Produce structured JSON records from a spreadsheet, keyed by column headers.
- Get a JSON DOM tree that preserves headings, lists, tables and formatting.
- Auto-fill a `text_long` field from a file field on entity save.
- Auto-fill a `string_long` field from an uploaded document.
- Choose per-field output: plain text, HTML, Markdown, or JSON.
- Render document H1 as `<p class="h1">` to avoid clashing with the page H1.
- Give an AI agent a `file_to_text` tool to read a document by file id.
- Let an agent read a document by file location/URI.
- Summarise an uploaded report through an AI pipeline.
- Answer questions from a set of uploaded policy documents.
- Index a document archive for retrieval / embeddings.
- Chunk extracted text before sending it to a model.
- Load documents programmatically via the `document_loader:file` plugin.
- Install `poppler-utils` for higher-fidelity PDF extraction.
- Register a custom extractor for a new file type as a tagged service.
- Keep the third-party PDF and Office parsers patched.
- Decide deliberately what document content may be sent to a hosted model.
