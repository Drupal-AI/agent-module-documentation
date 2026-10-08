# Page Cache Single — manual setup guide

**Page Cache Single** (`page_cache_single`) forces Drupal to store a **single**
page‑cache entry per page for **anonymous** users. By default Drupal can store
many variants of the same page (for example one per query string), which can make
the `cache_page` database table grow large. This module collapses those variants
so there is one cache entry per content page and one for 404s — significantly
shrinking the `cache_page` table.

It is a good fit for sites that do **not** display different content based on the
query string for anonymous visitors. It builds on core's **Internal Page Cache**
and only affects anonymous page caching; it has no effect on logged‑in users and
plays no role in content or access control.

There is one important assumption to check before you enable it: collapsing the
variants only makes sense if your pages don't legitimately vary per request for
anonymous users. If any anonymous page is personalized per request (for example by
a query parameter that changes what is shown), serving a single shared cache entry
could show the wrong variant. Verify that no such per‑request anonymous
personalization exists on your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and ensure core Page
   Cache is enabled.

There is **no configuration page** for this module — it works for anonymous users
as soon as it is enabled, with no settings to adjust.
