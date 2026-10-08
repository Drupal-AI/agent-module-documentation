<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fast Error Pages serves the site's own themed 404 and 403 pages to anonymous visitors without a full page render each time, so a flood of invalid URLs stays cheap while the branded error page is preserved.

---

Error responses are the cheapest thing a site should serve and often the most expensive: every 404 renders the whole themed page — menus, blocks, everything — and a site being crawled or scanned takes thousands of them. Core's Fast 404 answers this by returning static HTML, at the cost of losing the themed page entirely. This module keeps the themed page and caches it. The mechanism is worth understanding: an exception subscriber (`FastErrorPageHtmlExceptionSubscriber`, priority 250) intercepts the error **for anonymous users only**, and on the configured error page it performs a **loopback HTTP request** to the site itself — marked with an `X-Drupal-Fast-Error-Pages` header so the subscriber skips its own request — which the site's page cache answers cheaply. A first (cold) hit uses a POST to force a real render; a companion response subscriber (`FastErrorPageStoreCacheInfo`) captures that page's **cache tags and contexts** into the module's `fast_error_pages_cache_bin`, and subsequent warm hits are served with those tags plus `4xx-response` / `url`, so Drupal's ordinary invalidation still applies — the improvement over Fast 404 the README claims. Which pages are used comes from `system.site` `page.404` / `page.403`, not from the request path. There is a `FastErrorPage` plugin type (one per status code, id = the code; 404 and 403 ship built in) and a `hook_fast_error_pages_cache_contexts_alter` hook, which matters more than it sounds: the default cache id is the status code alone, so a multilingual or multi-domain site must add to it or one language's 404 will be served to every visitor.

---

- Serve 404s without a full themed page render.
- Reduce load from crawlers hitting invalid URLs.
- Keep a branded, themed error page while caching it.
- Improve performance under a scanning bot storm.
- Cache 403 access-denied responses too.
- Preserve cache tags on error pages so they invalidate normally.
- Avoid core Fast 404's static-HTML limitation.
- Reduce database and render load from error traffic.
- Handle a spike of broken inbound links after a migration.
- Serve error pages efficiently behind a reverse proxy.
- Invalidate cached error pages automatically on content change.
- Add a `FastErrorPage` plugin for another status code (410, 500).
- Vary cached error pages per language on a multilingual site.
- Vary cached error pages per domain on a multi-site/domain setup.
- Reduce origin load behind a CDN such as Cloudflare.
- Improve response time for missing pages.
- Support a high-traffic site's error handling.
- Keep the themed 404 without paying its render cost each hit.
- Reduce the cost of a link-rot backlog.
- Point 404/403 at a node and still serve it fast.
- Take pressure off the origin during a traffic surge of bad requests.
