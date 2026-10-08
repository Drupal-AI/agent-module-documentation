<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader HTML Processor - URL (document_loader_html_processor_url) — agent index

An **opt-in submodule** of `document_loader_html_processor`, **disabled by default**. It adds an
HTTP GET fetch step in front of the `html_processor` pipeline: hand it a URL and it fetches the
page and runs the returned HTML through the same processing pipeline as the base module. Enable it
only when you want the server to make **outbound HTTP requests** to a caller-supplied URL.

- Package `Document Loader HTML Processor`. Core `^10.4 || ^11`. PHP `>=8.2`. License
  GPL-2.0-or-later. Version 2.0.x (installed 2.0.0-rc2). Security advisory: **not covered**.
- Depends on `document_loader_html_processor` (its parent) and `document_loader`
  (`html_processor` comes transitively via the parent).
- **No routes, no permissions, no config, no config schema, no admin form.** Ships in the parent
  package (no own `composer.json`).
- Minimal by design: **no Readability extraction, no Markdown conversion, no retries** — for those
  use `document_loader_webpage`.

## Solution docs

- **The URL loader plugin, the fetch mechanics, the guards, and every option** →
  [plugins/url-loader.md](plugins/url-loader.md)
- **The `dlhpu:test` Drush command** → [drush/commands.md](drush/commands.md)

## What it actually provides (from source)

- `DocumentLoader` plugin **`document_loader_html_processor_url.html_processor_url`** —
  `src/Plugin/DocumentLoader/HtmlProcessorUrlLoader.php`, extends `DocumentLoaderBase`, uses the
  parent's `HtmlProcessorTrait`. `document_loader_types: ['document_loader_type:website']`,
  `output_types: ['html']`.
- `load()` requires a `WebsiteUrlInput`, calls `fetchUrl()`, sets `base_url ??= $url`, then runs
  the parent's `processHtml()`; returns an `HtmlOutput` with metadata `{source, options}`.
- `fetchUrl()` — the fetch: scheme guard (`ALLOWED_SCHEMES = ['http','https']`), streaming GET via
  injected `http_client`, redirect-protocol pinning, Content-Type allowlist
  (`text/html`, `application/xhtml+xml`, `application/xml`, `text/xml`), 10 MB cap (pre-flight
  `Content-Length` + bounded 8 KB chunked read), timeouts from the input, and `redactUrl()` to
  strip `user:pass@` credentials from error messages.
- Drush command class `HtmlProcessorUrlTestCommands` (`src/Drush/Commands/…`) — `dlhpu:test`.
- Reuses the parent's `HtmlProcessorInterface` facade and `DocumentLoaderHtmlProcessorException`.

## Notes

- The fetched URL is auto-set as `base_url` for relative `href`/`src` resolution unless the caller
  passes an explicit `base_url`.
- The loader has **no route of its own**; it is invoked programmatically, via the `document_loader`
  Explorer form / tool integration, or via `dlhpu:test`. TLS verification is left at Guzzle's
  secure default.
- HTML processing options are read from the flat `WebsiteUrlInput` metadata; URL-specific keys
  (`timeout`, `follow_redirects`, `max_redirects`, `user_agent`) are read by the input's accessors
  and dropped before the html_processor pipeline (the trait's `array_intersect_key`).
