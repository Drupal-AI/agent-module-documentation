# Document Loader: HTML Processor — manual setup guide

**Document Loader: HTML Processor** (`document_loader_html_processor`) is a **bridge
module**. It exposes the [HTML Processor](https://www.drupal.org/project/html_processor)
module's HTML-cleaning services as a **Document Loader plugin**, so pipelines built
on the Document Loader plugin manager can take an HTML string and run it through
HTML Processor's pipeline — returning clean, narrowed HTML ready for AI systems,
search indexes, or data migration.

What the pipeline can do (all driven programmatically by the calling code, not a UI):
extract a specific content region with CSS selectors (`main`, `article`,
`.content-body`), strip unwanted markup with regex patterns, remove advertising
elements (AdSense, DoubleClick, Taboola, Outbrain, Media.net), rewrite relative
`href`/`src` attributes to absolute URLs using a caller-supplied base URL, sanitize
with Symfony's HtmlSanitizer, wrap output in a full HTML document when needed, and
minify whitespace to cut token count for AI pipelines.

This is **developer plumbing** — it has no content, no permissions of consequence,
and **no admin form of its own**. The base module processes HTML you already have in
memory; you pass that HTML (and options) in code. A separate, opt-in submodule,
**`document_loader_html_processor_url`**, ships inside this package and is disabled
by default — enable it only when you want the *server* to fetch a URL and run the
returned HTML through the pipeline. It depends on **Document Loader** (`^2.0`) and
the **HTML Processor** module (`^1.0`).

> **Versioning note.** This module's major version tracks Document Loader's — the
> 2.x line here requires Document Loader 2.x, 3.x will require Document Loader 3.x,
> and so on. Note also that this project is **not covered** by Drupal's security
> advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside HTML
   Processor and Document Loader, and optionally enable the URL submodule.

There is **no configuration page** for this module — all processing options are
passed programmatically. Once enabled, the plugin appears in the Document Loader
listing at **Configuration → Media → Document Loader**, but there is no per-plugin
form to fill in.

## Where it lives in the admin menu

The plugin surfaces in the Document Loader configuration at **Configuration → Media
→ Document Loader** (`/admin/config/media/document-loader`) as an available loader.
It adds no settings page of its own.

## How developers use it

A consumer creates the plugin instance from the Document Loader plugin manager and
passes an HTML string plus options — for example a CSS `container` to extract,
`remove_ads`, a `sanitizer` mode, and a `base_url` for resolving relative links.
The base module never fetches anything itself; pass already-resolved HTML. See the
module's `README.md` for the full options reference.

## About the URL submodule

If you enable `document_loader_html_processor_url`, the server will fetch a URL you
give it and process the response. It includes guards — an http/https scheme
allowlist, a content-type check, a 10&nbsp;MB response cap, bounded streaming reads,
redirect protocol pinning, and credential-safe error messages. Read the submodule's
`README.md` for its full considerations and known limitations.
