# HTML Processor — manual setup guide

**HTML Processor** (`html_processor`) is a developer‑oriented toolkit for cleaning up
messy HTML from any source before you store, convert, or index it. When you feed a
Markdown converter or a search index a raw web page, you get navigation, ads, and
boilerplate mixed in with the content you actually wanted. HTML Processor strips that
noise first, so whatever happens downstream stays clean and token‑efficient.

It runs a configurable pipeline that can:

- **Extract the content you want** with CSS selectors (`article`, `#main-content`)
  and drop everything else.
- **Remove ads and boilerplate** using built‑in patterns for common ad networks,
  plus any of your own.
- **Strip unwanted fragments** with admin‑trusted regular expressions (guarded
  against catastrophic‑backtracking ReDoS).
- **Rewrite relative links and images** to absolute URLs so they keep working out of
  context.
- **Sanitize** elements and attributes via the Symfony HTML Sanitizer.
- **Shape the output** — wrap it as a full HTML document, or minify it.

You can pass options for a single call from code, or save a default pipeline in the
admin form and have it applied automatically. It's standalone — no other Drupal
modules are required, just a few small Symfony/League Composer libraries that install
automatically. Typical use cases are cleaning HTML before Markdown conversion, AI/RAG
ingestion, migrations, or search indexing — anywhere you pull content from sources
you don't control.

> **Security note:** the regex‑stripping and ad‑pattern features are **admin‑trusted
> only** — they are never safe to build from anonymous user input. And because the
> sanitizer settings decide what markup survives, correct sanitization configuration
> matters for XSS safety. Review your settings with that in mind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the default‑pipeline settings form and
   how the options behave.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → HTML Processor**,
gated by the **Administer HTML Processor settings** permission. These settings are
opt‑in defaults; explicit options passed in code always win.

## How to use it (for developers)

In code, inject `HtmlProcessorInterface` and call `process()`:

```php
$clean = $this->htmlProcessor->process([
  'content' => $rawHtml,
  'container' => 'article, #main-content',
  'remove_ads' => TRUE,
]);
```

The full service API, the Drush command, and autowiring setup are described in the
module's `README.md`.
