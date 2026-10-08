<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
An opt-in submodule that adds a URL-fetch step in front of `document_loader_html_processor`: give it a URL and it fetches the page over HTTP GET and runs the returned HTML through the `html_processor` pipeline.

---

`document_loader_html_processor_url` ships inside the `document_loader_html_processor` package and is **disabled by default**. It registers one `DocumentLoader` plugin (`document_loader_html_processor_url.html_processor_url`) for the framework's standard website type (`document_loader_type:website`, `WebsiteUrlInput`). On `load()` it validates the URL's scheme (http/https only), performs a single streaming GET with Drupal's `http_client` (Guzzle) honouring the input's timeout / redirect / user-agent settings, enforces a Content-Type allowlist and a 10 MB size cap via a bounded chunked read, then hands the raw HTML to the same `HtmlProcessorTrait` pipeline the base module uses — auto-injecting the fetched URL as `base_url` so relative links resolve. It is deliberately minimal: no Readability extraction, no Markdown conversion, no retries (use `document_loader_webpage` for those). It provides a `dlhpu:test` Drush command and no routes, permissions, config, or admin form of its own. Because it makes the server issue outbound requests to a caller-supplied URL, treat that URL as untrusted and gate who can invoke the loader.

---

- Fetch a public web page and clean its HTML in one call, without pre-fetching it yourself.
- Pull an `article`/`main` region out of a live page for an AI or RAG ingestion pipeline.
- Fetch and sanitize a remote page down to a safe element allowlist before storing it.
- Fetch a page and strip its ad networks (Google, Taboola, …) before republishing an excerpt.
- Fetch a page and rewrite its relative links to absolute using the fetched URL as base.
- Normalize a remote page's markup before handing it to a search indexer.
- Minify fetched HTML to reduce token count for an LLM.
- Convert a fetched fragment into a full HTML document via `output_full_document`.
- Fetch with a custom request timeout for slow origins.
- Fetch with redirects disabled, or with a bounded maximum redirect count.
- Fetch with a custom `User-Agent` header for sites that require one.
- Override the auto-detected `base_url` when the canonical URL differs from the fetched one.
- Expose "load a website and process its HTML" as an AI tool through `document_loader`'s tool integration.
- Test a URL fetch + transform from the CLI with `drush dlhpu:test --url=... --container=...`.
- Save a large fetched-and-processed result to a file with `--out=output.html`.
- Reject non-HTML responses early via the Content-Type guard (binary/image/JSON are refused).
- Abort oversized or endless responses safely via the streaming 10 MB cap.
- Run the same html_processor pipeline as the base module but sourced from a URL instead of memory.
