# Document Loader — manual setup guide

**Document Loader** (`document_loader`) is a **normalization layer** for getting
documents into Drupal in one consistent shape. Documents arrive in wildly different
forms — a PDF, a Word file, a web page, a plain-text upload have almost nothing
structurally in common — and every feature that wants to process them ends up
reinventing the same conversion logic. Document Loader fixes that: **sources become
plugins**, the output is normalized, and whatever consumes the documents works
against a single, predictable shape.

If you have used LangChain's "document loaders," the pattern (and the reasoning)
will feel familiar. On a current Drupal site the most likely use is feeding an **AI
/ RAG pipeline** — retrieval-augmented generation needs documents chunked and
embedded, and getting them into a uniform form is step one — but it is equally at
home preparing content for a **search index** or a **migration**. Being
source-agnostic is exactly what makes it worth having as a shared layer rather than
baked into one feature.

On its own, Document Loader provides the framework: the plugin system, the common
input/output interfaces, reusable output types (JSON, CSV, Markdown, and so on),
runtime plugin discovery, and a settings page where you map loader *types* to the
concrete loader *plugin* that should handle them. **The actual loading is done by
companion plugin modules** — you install one or more depending on what you need to
ingest (see the recommended modules below). It depends only on core's **File**
module.

**Two things are worth settling whenever you ingest documents.** First, *access
follows content*: a loader that reads a private file has moved that content into a
new place, potentially with different access rules — understand where it lands.
Second, *document extraction is an attack surface*: PDF and Office parsers are
historically a rich source of vulnerabilities, so know which library does the
extraction and keep it patched.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Document Loader and at least one
   loader plugin module.
2. [Configuration](configuration/index.md) — map loader types to plugins and test
   loading your own documents.

## Where it lives in the admin menu

Document Loader's settings and testing tools live at **Configuration → Media →
Document Loader** (`/admin/config/media/document-loader`; the module's configure
route is `document_loader.settings_form`). Access is gated by the
`document_loader.administer` permission.

## Recommended companion modules

Document Loader is only as capable as the loader plugins you install alongside it.
Common choices include:

| Module | Handles |
|--------|---------|
| [PDF Parser](../../../document_loader_pdfparser/1.2.x/human-docs/index.md) | PDF files |
| [PHPWord](../../../document_loader_phpword/1.0.x/human-docs/index.md) | Word, `.doc`/`.docx`, ODT, RTF |
| [Webpage](../../../document_loader_webpage/1.0.x/human-docs/index.md) | Remote web pages |
| [HTML Processor](../../../document_loader_html_processor/2.0.x/human-docs/index.md) | HTML content / web pages |
| [Plugin - API](../../../document_loader_plugin_api/1.0.x/human-docs/index.md) | HTTP/HTTPS API responses |

Others exist too (for example an AI File To Text loader and a Parquet loader).
Install whichever match the document types you need to ingest.
