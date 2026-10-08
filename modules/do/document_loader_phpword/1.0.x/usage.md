<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extracts the content of Word and RTF documents as plain text, HTML, or Markdown for the Document Loader framework, using the phpoffice/phpword library.

---

Document Loader: PHPWord is a plugin for the `document_loader` module. It contributes one `DocumentLoader` plugin (`document_loader_phpword:phpword`) that opens Word 2007+ (`.docx`), Word 2003 (`.doc`), OpenDocument Text (`.odt`), and Rich Text Format (`.rtf`) files through PHPWord and returns their text content in one of three output formats: plain `text`, `html`, or `markdown`. It handles the framework's built-in `document_loader_type:word` type and adds its own `document_loader_type:rtf` type (with an `RtfInput` value object). Text extraction walks the parsed document element tree (paragraphs, headings, tables, lists) in document order; HTML comes from PHPWord's own HTML writer (body-only); Markdown is built by a dedicated `PhpWordToMarkdown` converter that renders headings, bold/italic/strikethrough runs, links, bullet/numbered lists, and pipe tables. Document properties (title, author, dates, etc.) are returned as output metadata. A per-load boolean option (`header_and_footer`) can include the first header and last footer. The module has no admin UI of its own — once enabled it simply shows up as an available plugin in the Document Loader configuration at `admin/config/media/document-loader`, and it is normally driven programmatically or by other Document Loader consumers (e.g. AI document ingestion, search indexing, migrations). RTF handling is best-effort due to limitations in PHPWord's RTF reader.

---

- Extract the plain text of an uploaded `.docx` file for full-text search indexing.
- Convert a Word document to Markdown for storage in a text field or AI prompt.
- Convert a Word document to clean HTML (body only, without PHPWord's boilerplate wrapper).
- Ingest `.odt` (OpenDocument Text) files exported from LibreOffice/OpenOffice.
- Best-effort extraction of legacy Word 2003 (`.doc`) documents.
- Best-effort extraction of Rich Text Format (`.rtf`) documents.
- Feed Word document text into an AI/LLM pipeline built on Document Loader.
- Preserve document structure (headings become Markdown `#` levels; tables become pipe tables).
- Convert bold, italic, and strikethrough runs into Markdown emphasis markers.
- Turn Word hyperlinks into Markdown `[label](url)` links.
- Flatten Word tables into tab-separated lines for plain-text output.
- Capture document metadata (title, subject, keywords, creator, company, created/modified dates).
- Optionally include the document's first header and last footer in the extracted output.
- Read files from Drupal stream wrappers such as `public://` and `private://`.
- Read files from remote stream wrappers (e.g. `s3://`) by copying bytes to a temporary local file for parsing.
- Migrate content held in Word documents into Drupal entities.
- Pre-process attachments before running summarization or classification models.
- Normalize mixed Office/RTF uploads to a single Markdown representation.
- Select the loader per document via the Document Loader plugin selection when multiple loaders can handle a type.
