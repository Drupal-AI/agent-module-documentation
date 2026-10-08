<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fast Error Pages (fast_error_pages) — agent index

Serves the site's own **themed** 404 and 403 pages to **anonymous** visitors without a full
render. It captures each configured error page's cache metadata and re-serves the page from a
cheap loopback HTTP fetch (which the site's page cache answers), keeping the themed page that
core's Fast 404 cannot. No dependencies, no routes, no permissions, no settings form.
Core: `^10.3 || ^11`.

- **Which pages are served, the caching requirement, runtime flow** → [configure/setup.md](configure/setup.md)
- **Add support for another status code (410, 500, …)** → [plugins/fast_error_page.md](plugins/fast_error_page.md)
- **Vary the cache per language / domain** → [hooks/cache_contexts_alter.md](hooks/cache_contexts_alter.md)

Key facts:
- Handles **anonymous** requests only; authenticated users fall through to core (you see no effect logged in).
- Error page URLs come from `system.site` config `page.404` / `page.403` — never from the request path.
- Plugin type **`FastErrorPage`** — attribute `Drupal\fast_error_pages\Plugin\FastErrorPage`,
  manager service `fast_error_pages.error_page_manager`; plugin **id = the status-code integer**;
  discovered in each module's `src/FastErrorPage/` namespace.
- Built-in plugins: `FastErrorPage404` (id 404), `FastErrorPage403` (id 403).
- Services: `fast_error_pages.exception_subscriber`, `fast_error_pages.error_page_cache_info`,
  `cache.fast_error_pages` (cache bin `fast_error_pages_cache_bin`).
- Alter hook: `hook_fast_error_pages_cache_contexts_alter(array &$cid_parts)`.
- Default cache id = the bare status code, so every 404 shares one entry — vary it via the hook on
  multilingual / multi-domain sites.
- Requires a full-page cache layer (Internal Page Cache / reverse proxy) to gain anything.
