<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LSCache is a Drupal.org-native LiteSpeed Cache integration that adds the response headers LSWS needs to cache Drupal pages keyed by Drupal cache tag, then invalidates those pages from Drupal (via the Purge framework) when the underlying content changes.

---

LiteSpeed Web Server can serve a full-page cache in front of Drupal, but it needs to know each response's TTL and which cache tags it carries, and it needs a signal to drop cached pages when content changes. This module's `LscacheResponseSubscriber` attaches `X-LiteSpeed-Cache-Control` (TTL) and `X-LiteSpeed-Tag` (Drupal cache tags) headers to cacheable main-request responses; the `lscache_purger` submodule plugs into Purge so a node edit or config save issues a tag-scoped PURGE and LSWS drops every response carrying that tag. Header emission alone does nothing until LSWS is told to consult its cache with a `CacheLookup public on` directive in `.htaccess`; the module ships Status-report checks for the required directives. 1.3.x adds private (per-user) caching derived from Drupal cache contexts, `X-LiteSpeed-Vary` cookie support, a Host-header override and a URL/tag/auto PURGE strategy (with a self-populating tag-affinity table for listing pages), plus Drush diagnostics (`lscache:diag`, `lscache:list-tag-coverage`). ESI fragments (1.2.x+) let a per-user chunk stay per-user while the surrounding page stays shared.

Security posture (already reviewed — sound): the settings route `lscache.settings` is gated by `administer lscache` (`restrict access: true`). The public `/lscache-fragment/{token}` route uses `_access: 'TRUE'` but every token is HMAC-SHA256 signed on the site hash salt (`LscacheTokenSigner`) so fragments cannot be forged or enumerated, and the target callback must implement `TrustedCallbackInterface` (as core requires for `#lazy_builder`). The purger's `verify => false` on its PURGE requests is loopback/origin-direct only. This module is documentation-only in this batch; no re-investigation performed.

Setup: add the `.htaccess` block, enable the module, turn on header injection at `/admin/config/development/performance/lscache` once LSWS is confirmed, and (for invalidation) enable `lscache_purger` with drupal/purge and set the purge host.

---

- Serve Drupal's cacheable pages from LiteSpeed without hitting PHP
- Tag LSWS cache entries with Drupal cache tags (`node:42`, `user:7`, …)
- Invalidate LSWS pages automatically on node/config changes via Purge
- Set a default cache TTL emitted as `X-LiteSpeed-Cache-Control`
- Prefix emitted tags to scope several sites sharing one LiteSpeed cache
- Cache authenticated pages per user with private-cache mode
- Vary cached pages by a cookie (device class, currency, country, A/B bucket)
- Verify caching with `x-litespeed-cache: hit/miss` via curl
- Diagnose the .htaccess directives from the Status report
- Choose a PURGE strategy (tag/url/auto) for LSWS builds that ignore tag-PURGE
- Probe your LSWS build's PURGE behaviour with `drush lscache:diag`
- Evict listing pages (views/blocks) via the tag-affinity table or a static URL map
- Pin listing URLs for a specific aggregate tag in `static_url_map`
- Override the PURGE Host header so evictions hit the canonical-host cache bucket
- Promote a per-user page chunk to an ESI fragment with `#type => 'lscache_esi'`
- Drain the purge queue manually after a bulk import with purge_drush
- Enable debug logging to inspect the emitted tag payload during setup
- Toggle header injection off to stop contributing tags while LSWS keeps caching
