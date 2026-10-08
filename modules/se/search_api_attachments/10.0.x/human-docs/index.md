# Search API Attachments — manual setup guide

**Search API Attachments** (`search_api_attachments`) makes the *contents* of
uploaded files searchable. It extracts the text out of files attached to your
content — PDFs, Word and Excel documents, plain text, and more — and feeds that
text to Search API, so a search for a phrase buried inside a PDF actually finds
the document.

It works by adding a Search API processor called **File attachments**. Once you
enable that processor on an index, every file field gains a virtual "attachment
content" property (named `saa_<field_name>`) that you add to the index as a
searchable field. At indexing time the module loads each referenced file, checks
it against a set of rules (does it exist, is it a permitted type, is it under the
size limit, and so on), extracts the text, and stores it on that field.

The actual text extraction is delegated to a pluggable **extractor** — you choose
and configure exactly one. Options include Apache Tika (as a local JAR or a
running Tika server), the Search API Solr backend's own extract handler,
`pdftotext`, a Python `pdf2txt` script, and `docconv`. Extracted text is cached so
re‑indexing does not repeat the costly extraction, and files that fail extraction
are queued for a later retry. Search API Attachments depends on Search API and
Drupal core's File/Media handling.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose and configure an extractor,
   enable the processor, and add the attachment field to your index.

## Where it lives in the admin menu

The extractor settings form is at **Configuration → Search → Search API
Attachments** (`/admin/config/search/search_api_attachments`), gated by the
**Administer search_api_attachments** permission. The per‑field indexing options
live on your Search API index's **Processors** tab.

## How to use it

1. Make sure you have a working Search API index (Search API and a server backend
   are prerequisites).
2. Pick and configure a text extractor on the settings form.
3. On your index's **Processors** tab, enable **File attachments**.
4. Add the resulting `saa_<field_name>` property as a field on the index, then
   reindex.

See [Configuration](configuration/index.md) for every option.
