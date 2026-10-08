<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Document Loader plugin that extracts text, HTML or Markdown (plus metadata) from PDF files using the local smalot/pdfparser PHP library.

---

Document Loader: PDF Parser is a thin bridge plugin for the Document Loader framework. It registers one `DocumentLoader` plugin (`document_loader_pdfparser.pdfparser`) that handles the framework's built-in `pdf` input type and returns three output formats: plain **text** (via `smalot/pdfparser`), semantic **HTML** (via `ahmaadkhader/pdf-to-html`), and **Markdown** (the HTML converted with `league/html-to-markdown`). Every output also carries the PDF's metadata (page count, author, title, creation date, and so on) taken from the parser's `getDetails()`. The module contains no PDF logic beyond wiring these libraries together — it holds no routes, permissions, config schema, admin form or Drush commands of its own. Once the module is enabled it appears automatically on the Document Loader settings page, and any code, AI tool, or the Document Loader Explorer can select it to convert a PDF. All parsing happens locally in PHP, so no external PDF-to-text web service is required.

---

- Extract the full plain-text body of a PDF for indexing, search, or storage.
- Feed PDF text into an AI/LLM workflow (RAG, summarisation, classification) through Document Loader's tool layer.
- Convert a PDF to semantic HTML for on-site display or further processing.
- Convert a PDF to Markdown for a documentation pipeline or a headless front end.
- Read a PDF's metadata (page count, author, title, subject, keywords, creation/modification date) without extracting the body.
- Turn scanned-report PDFs stored in `public://` or `private://` into searchable text content.
- Bulk-migrate a library of PDF documents into Drupal nodes as text or HTML.
- Provide a "load this PDF into the editor" experience via the Document Loader MDX submodule.
- Add PDF support to a custom document-processing service that already speaks Document Loader.
- Render detected PDF headings as native `<h1>`–`<h6>` tags in HTML output using the `native_headings` loader option.
- Extract text from a PDF uploaded through the Media library and normalised by Document Loader.
- Download and parse a remote PDF (handled by the Document Loader framework's file normaliser) into text.
- Generate a Markdown preview of a contract or invoice PDF for quick review.
- Populate a body field or text field from an attached PDF during content import.
- Build a knowledge base by extracting text from many PDFs for a vector/embedding store.
- Attach PDF metadata (author, page count) to a media entity as computed fields.
- Offer PDF as one of several document sources in a multi-format loader configuration.
- Test PDF extraction quickly from the Document Loader Explorer admin form.
- Standardise PDF ingestion across modules by depending on this plugin instead of bundling a parser.
- Produce clean article HTML from a PDF newsletter for republishing.
