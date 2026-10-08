# Simple Crawler — manual setup guide

**Simple Crawler** (`simple_crawler`) fetches the content of web pages so other
parts of your site can use it — for research, SEO, AI context, or content
migrations. It is essentially a convenient wrapper around Guzzle/cURL with
readability logic layered on top, so it can pull just the main article out of a
page's body rather than the whole raw HTML.

The module surfaces its capability in two ways. First, it provides a **service**
(`simple_crawler.crawler`) that any other module can call to scrape a
server‑rendered page — either the full page or just the extracted article.
Second, it provides an **AI Automator type** for the AI Automator (part of the
[AI module](https://www.drupal.org/project/ai)): point a link field at it and the
automator can fill a long‑text field with the scraped title, image, HTML body, or
article — and it can even crawl several levels deep to pull in a whole site. Note
that because it uses cURL/Guzzle rather than a real browser, it cannot scrape
client‑side‑rendered (JavaScript) pages; for those the project points you to the
ScrapingBot module instead.

On its own, Simple Crawler does nothing visible — it is a building block. To
actually use it you need a consumer: either the AI Automator submodule of the AI
module, or your own custom code calling the service. This also replaces the older
"AI Interpolator Simple Crawler" module on Drupal 10.3+.

**A word on safety.** This module makes *your Drupal server* fetch URLs. If those
URLs come from content a non‑admin can set (for example a link field on an entity
a submitter controls), someone could steer the server at internal, non‑public
services — a classic server‑side request forgery (SSRF) risk. The crawl runs as a
batch process that is typically admin‑triggered, which limits who starts it, but
you should still validate or allow‑list any URLs that originate from untrusted
content, make sure TLS certificate verification stays on, and keep this module
restricted to trusted operators. Treat "crawl a URL a visitor supplied" as
something to guard, not something to do freely.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and wire it up to a consumer.

## How to use it

There is no settings form. You use Simple Crawler in one of two ways:

**As an AI Automator type.** Install the AI Automator from the AI module, then
create an entity or content type with a link field and a formatted long‑text
field. On that long‑text field, enable the AI Automator checkbox and configure it
to use Simple Crawler. When you create an entity and fill in the link, the
long‑text field is populated with the scraped page. Enable deep crawling if you
want it to follow links and pull in a whole site.

**From custom code, via the service.** For example, to get only the article text
of a page:

```php
$crawler = \Drupal::service('simple_crawler.crawler');
// TRUE = just the article, not the whole raw HTML.
$article_only = TRUE;
$article_text = $crawler->scrapePageAsBrowser('https://www.drupal.org/project/ai', $article_only);
```

In both cases, restrict use to trusted operators and be deliberate about which URLs
the server is allowed to fetch.
