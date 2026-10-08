# CacheAlter — manual setup guide

**CacheAlter** (`cache_alter`) makes two focused adjustments to Drupal's page
caching:

1. It **strips `utm_*` parameters from the cache key**. Campaign-tracking
   parameters like `utm_source` and `utm_campaign` change the URL but not the page
   content, so without this every UTM-tagged variant of a URL gets its own cache
   entry and the cache fragments. With CacheAlter, URLs that differ only by their
   UTM parameters share one cache entry, improving the cache hit rate.
2. It **adds a cookie-based cache context**, so cached output can vary by the
   value of a cookie.

It is purely a performance/caching feature — it stores no content and has no
access-control role. It supports Drupal 10 and 11.

Two honest caveats: adding a cookie cache context can *fragment* the cache by that
cookie's values, so only use it with a low-cardinality cookie (few distinct
values). And stripping UTM from the cache key is only safe if UTM parameters
genuinely do not change what your site renders — confirm nothing on your site
displays differently based on a UTM value before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

CacheAlter has no dedicated configuration page in the admin menu; it adjusts cache
behaviour once enabled. It provides no permissions of its own.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. UTM parameters are dropped from the page cache key automatically, so
   campaign-tagged URLs share a cache entry.
3. The cookie cache context becomes available for cached output to vary by a
   cookie — remember to use a low-cardinality cookie so you do not fragment the
   cache.
4. Verify that nothing on your site renders differently based on a UTM parameter,
   since those are no longer part of the cache key.
