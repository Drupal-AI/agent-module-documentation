# Preserve page cache — manual setup guide

**Preserve page cache** (`preserve_page_cache`) changes how Drupal's internal
**anonymous page cache** is invalidated. Normally, cached pages are cleared by
**cache tags** — a config change, a menu edit, or a block update can invalidate
large swathes of the page cache at once. On a high-traffic site, one of those broad
invalidations can wipe most of the anonymous cache and send a spike of traffic to
the backend. This module changes the strategy so anonymous pages expire on a
**timer** (their `max-age`) instead.

It does this by replacing the core page-cache middleware with its own version that
**drops most cache tags** when a page is written to the cache. Because the entries
no longer carry those tags, tag-based invalidation no longer clears them; they
simply live until their `max-age` expires. The module keeps **one exception**: for
node pages it retains the single `node:<id>` tag, so editing a node still clears
that node's cached page immediately.

This is aimed at sites sitting behind a reverse proxy or CDN that does not do
tag-based invalidation, where time-based or URL-based purging is the strategy
anyway. Keeping Drupal's internal cache alive the same way means that on an
external cache miss the page can still be served from Drupal rather than rebuilt.

There is **no configuration UI** — you enable the module and, separately, tune the
`max-age`/`Cache-Control` on your responses to control how long pages live. See
"How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Read this before enabling — it changes caching behaviour.** Because most cache
> tags are dropped, changes that would normally clear anonymous cached pages
> **will not** clear them immediately: permission changes, block changes, config
> and menu changes, and edits to non-node entities all stay cached until `max-age`
> expires. Only node pages keep immediate tag-based invalidation. Audit which
> changes on your site must be visible to anonymous visitors *immediately* before
> you turn this on — this is a deliberate trade of instant invalidation for cache
> longevity, not something you want on a site where that immediacy matters. Note
> also that this module is marked obsolete / seeking a new maintainer and targets
> Drupal 8–10.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Setup is enabling it and
tuning your response `max-age` — described below.

## Where it lives in the admin menu

Preserve page cache adds no admin page. It works purely by swapping the page-cache
middleware once enabled.

## How to use it

1. Confirm the trade-off above is acceptable for your site, ideally on a staging
   copy first.
2. Install and enable the module (see [Installation](installation/index.md)). The
   middleware swap takes effect immediately.
3. Because pages now expire by time rather than by tag, control how long they live
   by setting a sensible **`max-age`** on your responses — for example the page
   cache maximum age at **Configuration → Development → Performance**, and any
   `Cache-Control` headers your responses or CDN set. A longer `max-age` means
   longer-lived cache entries (and staler content); a shorter one means fresher
   pages but more backend work.
4. Editing a node still clears that node's page, so the most common editorial
   workflow keeps working without waiting for expiry.
