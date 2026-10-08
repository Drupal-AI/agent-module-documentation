# JSON:API Filter Cache Tags — manual setup guide

**JSON:API Filter Cache Tags** (`jsonapi_filter_cache_tags`) sharpens cache
invalidation for filtered JSON:API collections. By default, JSON:API puts a very
generic cache tag (such as `node_list`) on every collection response, which means
*any* node change invalidates *every* cached collection — including ones whose
results couldn't possibly have changed. On a busy decoupled site that's a lot of
wasted invalidations and re-renders.

This module replaces that broad tag, for supported filters, with a precise one
derived from the filter value. For example, a request filtering nodes by a
category reference gets a tag like
`jsonapi_filter:node:field_category:<uuid>` and is only invalidated when content
referencing *that* category actually changes. The result is far fewer
invalidations and noticeably better cache hit rates for decoupled front ends.

It's a caching/performance feature only — it has no role in access control.
JSON:API still enforces entity and field access on the data itself; this module
just changes how the responses are tagged for the cache.

**This module is in early development, so understand its limitations before
relying on it.** Currently it only handles:

- **Entity-reference-by-UUID filters** in exactly the form
  `?filter[field_reference_field_name.id]=UUID` — no other field types.
- **The `=` operator only** — `!=`, `IN`, `NOT IN`, and other operators are not
  supported.
- **Filters outside a condition group** — grouped conditions aren't supported.

For any filter it doesn't support, it simply falls back to Drupal's default cache
tag behaviour (the generic `node_list` tag), so nothing breaks — you just don't
get the finer-grained tag for those requests.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the improved cache tagging is behaviour that
applies automatically to supported filtered requests once the module is enabled.
There is nothing to configure.
