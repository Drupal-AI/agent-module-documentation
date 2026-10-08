# Advanced Internal Page Cache — manual setup guide

**Advanced Internal Page Cache** (`advanced_page_cache`) is a small
performance/infrastructure module for **developers**. Drupal core's Page Cache
module stores a full HTML response per URL for anonymous visitors, but the key it
caches under is essentially just the URL — there is no supported way to make one
path cache several *variants* depending on request context. This module adds
exactly that extension point.

It lets other modules append extra "parts" to the anonymous page-cache key, so a
single URL can be cached as several distinct versions — for example one per
country, per device class, per A/B-test bucket, or per value of a particular
cookie. It ships two small example submodules that demonstrate the idea:
**Cookie Page Cache** (`cookie_page_cache`) varies the cache by a cookie value,
and **IP Page Cache** (`ip_page_cache`) varies it by the visitor's IP address.

There is no settings page — the module is used by writing a little code (a tagged
service) or by enabling one of the example submodules. Note that every extra
cache part multiplies the number of stored variants per URL, so a
high-cardinality value like a raw IP address can bloat the cache and lower hit
rates. Key on bounded, normalised values.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how to implement
your own cache-id part — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the example submodules if you want them.

## Where it lives in the admin menu

Nowhere — this module has no admin pages, no permissions, and no settings form.
It is pure caching infrastructure. Everything happens either automatically (once
an example submodule is enabled) or through custom code.

## How to use it

1. Make sure Drupal core's **Page Cache** (`page_cache`) module is enabled — this
   module extends it and depends on it.
2. Enable Advanced Internal Page Cache.
3. Then choose one of two paths:
   - **Use a bundled example.** Enable `cookie_page_cache` to vary the anonymous
     cache by a cookie value, or `ip_page_cache` to vary it by client IP. These
     work as soon as they are enabled.
   - **Write your own cache-id part.** In a custom module, create a class
     implementing `AdvancedPageCacheInterface::getAdditionalCacheIdPart()` that
     returns a short string (a country code, a device class, an A/B bucket…) and
     register it as a service tagged `advanced_page_cache_cid`. The developer
     [`agent/`](../agent/start.md) docs walk through this.

Whichever route you pick, the anonymous page cache will start storing a separate
cached copy of each URL for each distinct value your part returns.
