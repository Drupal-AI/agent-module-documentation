<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Cache Single — agent index

**Forces a single cache entry per content/404 page for anonymous users** (shrinks `cache_page`). Depends on core
`page_cache`. Version **1.0.4**. Core `^10||^11`.

Performance — assumes anonymous output doesn't vary per request (verify no per-request anonymous personalization);
no content/access role.
