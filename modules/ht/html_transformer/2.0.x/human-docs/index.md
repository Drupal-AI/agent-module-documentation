# HTML Transformer — manual setup guide

**HTML Transformer** (`html_transformer`) is a developer tool, not a point-and-click
feature. It gives you a service that runs an HTML document through a pipeline of
small "transformer" plugins, each of which makes one specific change to the markup —
for example replacing deprecated `<b>` tags with `<strong>`, isolating the
`<main>` content after scraping a page, or swapping `<img>` tags for
`<drupal-media>` references during a content import.

You write (or reuse) transformer plugins and then call the service to apply them.
The service can run every plugin marked "automatic," or an explicit, ordered list
you pass in, so the transformations happen deterministically in the order you
choose. A migrate process plugin is also included so you can transform HTML field
values during a migration.

One important caveat: HTML Transformer is a **mechanical DOM tool** — it does not
sanitize or filter anything. If the transformed HTML will be shown to end users,
your code remains responsible for sanitizing it appropriately.

> **Version note:** the 2.0.x branch uses PHP's newer `\Dom\HTMLDocument` class and
> **requires PHP 8.4 or newer**. If you are on an older PHP version, use the 1.0.x
> branch instead, which uses the classic `\DOMDocument` and is otherwise identical.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the example and UI submodules.

There is **no configuration page** for this module. You use it from code, or
experiment with it through the optional UI submodule described below.

## How to use it

**From code** — call the transformer service on an HTML document:

```php
$service = \Drupal::service(\Drupal\html_transformer\HtmlTransformerInterface::class);
$service->transform($document);            // run all "automatic" plugins
$service->transform($document, plugins: ['first_plugin', 'second_plugin']); // ordered subset
```

Passing `plugins: []` parses and re-serializes with no transformation; passing
`NULL` (the default) runs all automatic plugins.

**Write your own transformer** — a plugin carries the `#[HtmlTransformer('id')]`
attribute, extends `HtmlTransformerPluginBase`, and implements
`transform(\DOMDocument $document): void`, mutating the document in place. Implement
`LoggerAwareInterface` if you want the logger passed to `transform()`.

**Try it interactively** — enable the `html_transformer_ui` submodule (see
[Installation](installation/index.md)), then visit **`/html-transformer/transform`**.
Paste in some HTML, pick which plugins to run, and the page shows the serialized
output and a log. Access is gated by the `use html_transformer_ui` permission, so
grant that only to trusted users.
