<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Varnish cache integrates Drupal with a Varnish reverse-proxy: it emits the cache-control and cache-tag headers Varnish needs, invalidates content by cache tag using BAN requests, and supports ESI so per-user fragments stay dynamic while pages are cached. Requires Drupal core `^10.1 || ^11 || ^12`.

---

All behavior is driven by the config object `adv_varnish.cache_settings`, split into `general` (Varnish server host(s), secret, page TTL, grace, a per-site `noise` key, debug/logging, and the built-in purger toggles), `available` (enable caching, cache for authenticated users, ESI support, ESI user-block purging, and URL filter mode/rules), and `cache_control` (the Cache-Control header strings sent to anonymous vs authenticated users). A separate "Redirect" tab on the settings form stores two flags in **state** (not config): `adv_varnish__redirect_forbidden` and `adv_varnish__redirect_forbidden_nocookie`, controlling the cookie-update reload behavior. `general.varnish_server` accepts multiple space-separated hosts; each is BANned in turn and gets an `http://` scheme prefix if none is given. A `CacheableResponseSubscriber`/`RequestHandler` set the response caching headers based on those settings and whether caching applies to the current user/route, while the `adv_varnish.cache_manager` service (tagged `cache_tags_invalidator`) translates Drupal cache-tag invalidations into Varnish **BAN** requests to the configured server(s), and also offers full-flush, purge-by-URI and "deflate" (progressive TTL reduction) operations — all gated by the `general.varnish_purger` toggle, skipped during maintenance mode when configured, and sent with short Guzzle timeouts (5s request / 2s connect) so a down Varnish never hangs Drupal. Per-request TTL respects a node-type third-party TTL override and the response's own `no-store` / `s-maxage` Cache-Control directives. The module defines a **`user_blocks`** plugin type (namespace `Plugin/UserBlocks`, base `UserBlockBase`) whose plugins supply per-user content delivered through ESI routes so the surrounding page can be cached anonymously; a second ESI route renders a placed block entity by ID. Admin screens under `/admin/config/development/adv_varnish` provide the settings form and, when the purger is enabled, manual "Clear Varnish cache" (purge by tag/URL) and "Deflate" forms; two permissions govern configuration access and a per-role cache bypass.

---

- Serve Drupal pages from a Varnish reverse proxy for high-traffic anonymous performance.
- Invalidate only affected pages by sending cache-tag BAN requests to Varnish when content changes.
- Send tuned Cache-Control headers to anonymous vs authenticated users.
- Enable Varnish caching for authenticated users where appropriate.
- Use ESI to keep per-user fragments dynamic while caching the rest of the page.
- Deliver per-user "user blocks" via ESI through a custom plugin.
- Render a placed block entity as an ESI fragment (per-page/per-role/per-user cache mode).
- Purge Varnish for a specific cache tag or URL from the manual purge form.
- Fully flush the Varnish cache for a site during a deployment.
- "Deflate" the cache by progressively lowering TTLs instead of a hard purge (processed via cron).
- Set a global page cache TTL and a grace period for stale-while-revalidate behavior.
- Override page TTL per node type via the node-type form's Advanced Varnish settings.
- Honor a response's own no-store / s-maxage Cache-Control directives when computing TTL.
- Prevent Varnish purges during maintenance mode to avoid thundering-herd cache misses.
- Point the module at multiple Varnish servers (space-separated) for a purge fan-out.
- Exclude or include specific URLs from caching via host|path blacklist/whitelist rules.
- Give trusted roles a permission to bypass Varnish entirely for debugging.
- Add a per-site "noise" key to vary cache keys and segment cached content.
- Purge a user's ESI user blocks on POST so their personalized content refreshes.
- Debug cacheability by enabling the module's debug/logging options.
- Integrate Varnish tag invalidation with Drupal's standard cache tag system automatically.
- Roll out edge caching to a Drupal site without writing custom VCL glue in Drupal.
- Implement a custom UserBlocks plugin to inject dynamic account info (name, cart count) via ESI.
- Manage all Varnish cache behavior from one settings form.
- Toggle the built-in purger on/off to control whether Drupal issues BAN requests.
