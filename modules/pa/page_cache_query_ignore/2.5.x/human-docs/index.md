# Page Cache Query Ignore — manual setup guide

**Page Cache Query Ignore** (`page_cache_query_ignore`) is a performance module
that stops marketing and tracking query strings from fragmenting Drupal's
anonymous page cache. Out of the box, Drupal treats
`https://example.com/landing?gclid=abc` and
`https://example.com/landing?utm_source=news` as *different* pages and caches each
separately. On a busy site linked from ads, emails, and social posts, that means
thousands of near‑duplicate cache entries for what is really one page — bloating
the cache and hurting your hit rate.

This module fixes that by teaching the anonymous **Internal Page Cache** to ignore
the query parameters you nominate when it works out the cache key. Point it at the
usual suspects — `gclid`, `fbclid`, `msclkid`, the `utm_*` family, HubSpot and
LinkedIn tracking params — and every tagged variant of a URL collapses onto a
single cached page. As a bonus, it also sorts the remaining parameters, so
`?a=1&b=2` and `?b=2&a=1` share one entry too.

You can run it two ways: **exclude** the listed parameters (strip just those, keep
everything else) or **include** only the listed parameters (an allowlist — keep
things like `page` or `sort` that genuinely change the content, drop all others).
There's also an option to keep redirects working correctly when they depend on the
original query string. For developers, the parameter list can be adjusted at
runtime through an alter hook and two events.

A couple of caveats worth knowing: this only affects the anonymous Internal Page
Cache, and it is **not** a replacement for a properly configured CDN or reverse
proxy — think of it as a complement. It depends on core's **Internal Page Cache**
(`page_cache`) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with Internal Page Cache).
2. [Configuration](configuration/index.md) — the settings page: the parameter
   list, exclude vs. include, and the redirect option.

## Where it lives in the admin menu

Its settings form lives under core's Performance settings, at **Configuration →
Development → Performance → Page Cache Query Ignore**
(`/admin/config/development/performance/page_cache_query_ignore`), and requires the
core **Administer site configuration** permission.

## How to use it

1. Enable the module (it needs core's Internal Page Cache).
2. Open the settings page and list the query parameters you want ignored — for
   example `gclid`, `fbclid`, and the `utm_*` parameters.
3. Choose the **Ignore action** — *exclude* the listed params, or *include* only
   them (see [Configuration](configuration/index.md)).
4. Save, then run `drush cr` (or wait for the cache to expire) so old fragmented
   variants aren't served from cache. From then on, tagged URLs share one cached
   page.
