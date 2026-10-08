# Cache URL Query Ignore — manual setup guide

**Cache URL Query Ignore** (`cache_url_query_ignore`) improves your page cache hit
rate by telling Drupal to ignore certain query-string parameters when it decides
which cached page to serve. By default Drupal treats a URL with `?utm_source=news`
as a different page from the plain URL, so every tracking or marketing parameter
splits the cache into another variant. This module lets you list the parameters that
should be ignored, so those variants collapse back into one cached page.

The classic case is analytics and ad parameters — `utm_*`, `fbclid`, and the like —
which change nothing about the page a visitor actually sees but otherwise fragment
the cache and waste cache storage. It is a **Performance** feature that changes how
the cache is keyed; it has no role in content or access control.

**One important caution:** only ignore parameters that genuinely do *not* change the
page's output. If you ignore a parameter that *does* affect what's rendered (say, a
filter or a page number), Drupal may serve the wrong cached content to visitors. Keep
the list to purely cosmetic tracking parameters.

The module works on Drupal 10 and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module lets you specify which query parameters to ignore; those parameters are
then dropped from the cache key so URLs that differ only by them share one cached
copy. See the [`agent/`](../agent/start.md) docs for the exact configuration
mechanism.

## How to use it

Enable the module, then set the list of query parameters that should be ignored —
typically tracking parameters such as `utm_source`, `utm_medium`, `utm_campaign`, and
`fbclid`. From then on, requests that differ only by those parameters are served the
same cached page, improving your hit rate. Double-check that every parameter you add
truly has no effect on the rendered page before you include it.
