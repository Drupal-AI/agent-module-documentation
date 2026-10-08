# Simplehtmldom API — manual setup guide

**Simplehtmldom API** (`simplehtmldom`) is a thin bridge that makes the third-party
PHP Simple HTML DOM Parser library available to your Drupal code. It has no admin
screen, no settings and no visible feature of its own — it exists so that developers
can call the parser's API from custom modules.

The Simple HTML DOM Parser gives you the simplest way to walk an HTML document: load
some markup, then select and read or rewrite nodes using jQuery-style CSS selectors.
Its main appeal over strict parsers like core's `DOMDocument` is that it is tolerant
of broken, malformed real-world HTML. Typical uses are scraping structured data out
of a remote page during an import, cleaning up messy user-supplied HTML, extracting
links, images, meta tags or table rows, and transforming markup in a hook. From
version 2.x onward the library itself is **not** bundled in the module package; it is
declared as a Composer dependency (`simplehtmldom/simplehtmldom`) so you can track
whichever version you need, and Composer installs it for you.

Once enabled, a developer parses HTML with functions such as `str_get_html($html)`
and `file_get_html($url)`, then traverses the result with selectors like
`$dom->find('a')`. That is the whole surface of the module — everything else is code
you write.

A word on safety, because the responsibility sits with the calling code: anything you
fetch from a remote URL and parse should be treated as untrusted, and you should not
parse attacker-controlled markup and echo it back without sanitising it first.

This guide is written for a **human** — most likely a developer — setting the bridge
up. If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Composer
   library) and enable it.

## How to use it

There is nothing to configure. After enabling the module, call the parser from your
own module code, for example:

```php
// Parse an HTML string.
$dom = str_get_html($html);

// Or load and parse a page.
$dom = file_get_html($url);

// Select nodes with CSS-style selectors.
foreach ($dom->find('a') as $link) {
  $href = $link->href;
  $text = $link->plaintext;
}
```

Treat any remotely fetched HTML as untrusted, and sanitise anything you intend to
re-output.
