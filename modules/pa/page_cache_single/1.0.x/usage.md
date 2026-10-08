<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Cache Single forces a single page-cache entry per content/404 for anonymous users.

---

Page Cache Single **forces a single cache entry per page** — for anonymous users it makes Drupal store one
cache_page entry per content page (and one for 404s) instead of many variants, significantly shrinking the
`cache_page` table. It depends on core Page Cache.

Use it to reduce page-cache bloat. It is a performance feature affecting anonymous page caching; it has no content
or access role. Note: collapsing variants assumes the page output doesn't legitimately vary per request for
anonymous users — verify that holds for your site (e.g. no per-request anonymous personalization). Configure the
single-cache behavior.

---

- Force one cache entry per page.
- Collapse anonymous page-cache variants.
- Shrink the cache_page table.
- Depend on core Page Cache.
- Serve performance.
- Reduce cache bloat.
- Assume output doesn't vary per anonymous request.
- Verify no per-request anonymous personalization.
- Have no content/access role.
- Configure the behavior.
- Handle single caching.
- Collapse variants.
- Configure the cache.
- Reduce variants.
- Handle the cache.
- Shrink the table.
- Configure performance.
- Handle caching.
- Merge entries.
- Provide single page caching.
