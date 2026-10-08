<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fetches a web page over HTTP/HTTPS and returns its cleaned content as HTML, plain text, or Markdown, as a Document Loader plugin.

---

Document Loader Plugin - Webpage adds one `DocumentLoader` plugin (`document_loader:webpage`) to the `document_loader` framework. Given a `WebsiteUrlInput` (a URL plus optional request options), it issues a Guzzle HTTP GET, extracts the main article content with fivefilters/readability.php (falling back to the raw `<body>` when Readability finds nothing), strips `<script>`/`<style>` (and optionally `<nav>`/`<footer>`/`<aside>`), and returns the result in the requested output format: `html`, `text`, or `markdown` (Markdown via league/html-to-markdown, and the default when no format is given). Each result carries metadata (source URL, HTTP status, content type, fetch timestamp, and Readability-derived title/author/excerpt/site name). The plugin ships no routes, forms, permissions, config, or Drush of its own; it is invoked through the parent `document_loader` framework's surfaces (the Explorer admin form, the Tool API submodule for AI agents, the Field Widget Action submodule, the MDX editor dialog submodule, and the `document-loader:load` Drush command) or programmatically via `plugin.manager.document_loader` / `document_loader.manager`.

---

- Import an article or blog post from a public URL and store it as Markdown in a content field.
- Populate an MDX/rich-text editor with the cleaned text of a source web page.
- Give an AI agent a "load from website" tool so it can read and summarise a page at a given URL (via the `document_loader_tool` submodule).
- Convert a marketing landing page into plain text for further processing or indexing.
- Scrape the readable body of a documentation page and drop navigation, headers, footers, and ad/aside blocks.
- Pull a competitor's page content into a migration or content-audit workflow.
- Fetch a page and hand its Markdown to an LLM automator field (via the `document_loader_automator` submodule of the parent framework).
- Extract the title, author, and excerpt of a URL for building a link preview or citation.
- Batch-load a list of URLs from Drush (`drush document-loader:load --input url=…`) and pipe the text to a file or another command.
- Normalise HTML from arbitrary sites into a single Markdown format for a knowledge base.
- Convert a page to HTML output (scripts/styles removed) for safe re-display after your own sanitisation.
- Feed cleaned page text into a search index or embedding pipeline.
- Retrieve a page with a custom User-Agent and timeout to match a target site's expectations.
- Follow (or disable following of) HTTP redirects up to a configurable maximum when loading a URL.
- Strip navigation and advertisement chrome from a page before quoting or archiving it.
- Load a URL that points to a document file (e.g. a `.pdf`); the MDX dialog re-routes such URLs to the file loader instead of scraping.
- Build an editorial "import from URL" button that fills a field with a page's readable content.
- Compare the text of two URLs by loading each as plain text.
- Produce a Markdown snapshot of a page as part of a scheduled content-sync job.
- Extract just the main content of a paywalled-free article for offline reading in your app.
- Provide a reusable page-fetching step for any custom module that needs webpage-to-text conversion without reimplementing Guzzle + Readability.
