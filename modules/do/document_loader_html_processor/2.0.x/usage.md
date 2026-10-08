<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Document Loader bridge plugin that runs an in-memory HTML string through the `html_processor` pipeline (container extraction, regex stripping, ad removal, relative-URL rewriting, Symfony HtmlSanitizer) and returns cleaned HTML.

---

`document_loader_html_processor` registers a single `DocumentLoader` plugin (`document_loader_html_processor.html_processor`) and its input type (`document_loader_type:html_content`) with the `document_loader` plugin manager. The plugin is a thin bridge: it holds no HTML business logic of its own, instead delegating the entire transformation to the `html_processor` facade service (`HtmlProcessorInterface::process()`). Callers hand it HTML that is *already resolved* (loaded from a field, file, or HTTP response) via `HtmlContentInput`, together with a flat options array (`container`, `strip_regex`, `remove_ads`, `base_url`, `sanitizer`, `output_full_document`, `minify`); the loader validates size (10 MB cap), filters the options down to the pipeline's declared schema, expands the `safe`/`static` sanitizer shorthands, and returns an `HtmlOutput`. It provides no routes, no permissions, and no admin form — everything is code-driven. A `dlhp:test` Drush command exists for quick manual runs. To fetch HTML from a URL instead of passing it in memory, enable the opt-in `document_loader_html_processor_url` submodule (documented separately).

---

- Clean scraped or migrated HTML before storing it as node body content.
- Prepare web-page HTML for ingestion into an AI or RAG pipeline (minify to cut token count).
- Normalize HTML markup before feeding a search index.
- Extract just the `article` or `main` region from a noisy page and discard chrome.
- Strip `<script>`, comments, or tracking pixels from HTML with custom regex patterns.
- Remove Google AdSense / DoubleClick / Taboola / Outbrain / Media.net ad blocks from content.
- Remove a specific single ad network (e.g. only Google) while leaving others in place.
- Remove several named ad networks at once via `['networks' => ['google', 'taboola']]`.
- Apply custom ad-removal regex patterns, optionally alongside the common set.
- Rewrite relative `href`/`src` attributes to absolute URLs using a known source `base_url`.
- Sanitize untrusted HTML down to a safe element/attribute allowlist with the `safe` shorthand.
- Sanitize to a static (non-interactive) subset with the `static` shorthand.
- Pass a full Symfony `HtmlSanitizer` options array for fine-grained element/attribute control.
- Wrap a processed fragment in a complete HTML document (DOCTYPE/html/head/body) via `output_full_document`.
- Chain several transforms in one call (extract container + remove ads + sanitize + minify).
- Invoke the loader programmatically through `plugin.manager.document_loader` in custom code.
- Route the transform through the central `document_loader.manager` so validation and access hooks fire.
- Expose HTML cleaning as an AI tool (via `document_loader`'s tool integration) so an agent can process HTML content.
- Test a transform quickly from the CLI with `drush dlhp:test --content=... --container=...`.
- Save a large processed result to a file with `drush dlhp:test ... --out=output.html`.
- Guarantee a deterministic no-op (input returned unchanged) when no options are supplied.
- Reuse the same `HtmlProcessorTrait` pipeline logic that the URL submodule builds on.
