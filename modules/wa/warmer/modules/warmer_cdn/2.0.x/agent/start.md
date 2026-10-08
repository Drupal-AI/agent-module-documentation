<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# warmer_cdn — agent start

Submodule of **warmer**. Provides two `@Warmer` plugins that warm HTTP/edge caches with
asynchronous Guzzle GET requests: **`cdn`** (`CdnWarmer`) warms a configured URL list, and
**`sitemap`** (`SitemapWarmer`) collects URLs from XML sitemaps (via `vipnytt/sitemapparser`)
then warms them. Also warms Varnish and the Page Cache with no CDN. Shared extra settings
(on top of `frequency`/`batchSize`): `headers`, `verify` (SSL), `maxConcurrentRequests`
(default 10). No routes, permissions, services, or Drush of its own — configured through the
Warmer settings form.

- Config for both warmers (`warmer.settings:warmers.cdn` / `warmers.sitemap`, all keys, how to warm) → [configure/setup.md](configure/setup.md)
- Parent module (framework, plugin type, drush, cron) → [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md)
