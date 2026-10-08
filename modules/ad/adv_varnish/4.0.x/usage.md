<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Varnish cache integrates Drupal with a Varnish reverse-proxy: it emits the cache-control and cache-tag headers Varnish needs, invalidates content by cache tag using BAN requests, and supports ESI so per-user fragments stay dynamic while pages are cached.

---

All behavior is driven by the config object `adv_varnish.cache_settings`, split into `general` (Varnish server host, secret, page TTL, grace, a per-site `noise` key, debug/logging, and the built-in purger toggles), `available` (enable caching, cache for authenticated users, ESI support, ESI user-block purging, and URL filter mode/rules), and `cache_control` (the Cache-Control header strings sent to anonymous vs authenticated users). A `CacheableResponseSubscriber` sets the response caching headers based on those settings and whether caching applies to the current user/route, while the `adv_varnish.cache_manager` service (tagged `cache_tags_invalidator`) translates Drupal cache-tag invalidations into Varnish **BAN** requests to the configured server, and also offers full-flush, purge-by-URI and "deflate" (progressive TTL reduction) operations — all gated by the `general.varnish_purger` toggle and skipped during maintenance mode when configured. The module defines a **`user_blocks`** plugin type (namespace `Plugin/UserBlocks`, base `UserBlockBase`) whose plugins supply per-user content delivered through ESI routes so the surrounding page can be cached anonymously. Admin screens under `/admin/config/development/adv_varnish` provide the settings form and, when the purger is enabled, manual "Clear Varnish cache" (purge by tag/URL) and "Deflate" forms; two permissions govern configuration access and a per-role cache bypass.

---

- Serve Drupal pages from a Varnish reverse proxy for high-traffic anonymous performance.
- Invalidate only affected pages by sending cache-tag BAN requests to Varnish when content changes.
- Send tuned Cache-Control headers to anonymous vs authenticated users.
- Enable Varnish caching for authenticated users where appropriate.
- Use ESI to keep per-user fragments dynamic while caching the rest of the page.
- Deliver per-user "user blocks" via ESI through a custom plugin.
- Purge Varnish for a specific cache tag or URL from the manual purge form.
- Fully flush the Varnish cache for a site during a deployment.
- "Deflate" the cache by progressively lowering TTLs instead of a hard purge.
- Set a global page cache TTL and a grace period for stale-while-revalidate behavior.
- Prevent Varnish purges during maintenance mode to avoid thundering-herd cache misses.
- Exclude or include specific URLs from caching via blacklist/whitelist URL filter rules.
- Give trusted roles a permission to bypass Varnish entirely for debugging.
- Add a per-site "noise" key to vary cache keys and segment cached content.
- Point the module at a specific Varnish server host and secret for purge requests.
- Purge a user's ESI user blocks on POST so their personalized content refreshes.
- Debug cacheability by enabling the module's debug/logging options.
- Integrate Varnish tag invalidation with Drupal's standard cache tag system automatically.
- Roll out edge caching to a Drupal site without writing custom VCL glue in Drupal.
- Reduce origin load by caching authenticated traffic with ESI-personalized regions.
- Implement a custom UserBlocks plugin to inject dynamic account info (name, cart count) via ESI.
- Manage all Varnish cache behavior from one settings form.
- Toggle the built-in purger on/off to control whether Drupal issues BAN requests.
