# Fast Error Pages — manual setup guide

**Fast Error Pages** (`fast_error_pages`) improves performance by caching your
site's *themed* 404 (Not Found) and 403 (Access Denied) pages and serving them
from cache very early in the Drupal bootstrap — so a flood of invalid URLs does
not cost a full page render each time.

Error responses are the cheapest thing a site should serve and often the most
expensive: every 404 normally renders the whole themed page — menus, blocks,
everything — and a site being crawled or scanned takes thousands of them. Drupal
core's Fast 404 answers this by returning static HTML, at the cost of losing the
themed page entirely. This module keeps the themed page *and* caches it. On the
first miss it fetches your configured error page over an internal request to the
site, caches the result keyed on the status code, and serves that cached copy on
subsequent hits — for anonymous visitors. Crucially, the cached response keeps its
**cache tags and contexts**, so Drupal's ordinary invalidation still applies: when
related content or configuration changes, the cached error page is refreshed
automatically.

It works out of the box: once enabled, it automatically takes over handling of 404
and 403 errors, using whatever 404/403 pages you have set in **Basic site
settings**. There is no settings form. Two things are worth knowing. First, the
module assumes a full‑page caching layer or reverse proxy is in use (Drupal's
internal Page Cache / Dynamic Page Cache, or Varnish/Nginx/Cloudflare) — without
caching there is no performance gain. Second, the default cache id is the status
code alone, so a multilingual or multi‑domain site should extend it (via the
`hook_fast_error_pages_cache_contexts` alter) or one language's 404 could be served
to every visitor.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it starts working the moment
it is enabled. See "Where it lives" below for the one setting it relies on.

## Where it lives in the admin menu

Fast Error Pages adds no admin page of its own. It uses the 404 and 403 pages you
have already defined at **Configuration → System → Basic site settings**
(`/admin/config/system/site-information`), under *Error pages*. If you want a
branded 404/403, set those pages there — Fast Error Pages will cache and serve
them.
