CDN Warmer is a submodule of Warmer that warms edge/HTTP caches by issuing HTTP GET requests — to an explicit list of URLs (`cdn` warmer) or to every URL discovered in an XML sitemap (`sitemap` warmer). It also warms Varnish and Drupal's Page Cache even without a CDN.

---

CDN Warmer registers two `@Warmer` plugins in `src/Plugin/warmer/`: `cdn` (`CdnWarmer`) warms a configured list of URLs, and `sitemap` (`SitemapWarmer`) collects URLs from one or more XML sitemaps (via the `vipnytt/sitemapparser` library) and warms those. Both make asynchronous Guzzle GET requests and share settings on top of the base `frequency`/`batchSize`: `headers` (custom request headers, `Name: value1; value2` per line), `verify` (SSL certificate verification on/off), and `maxConcurrentRequests` (parallelism, default 10). The `cdn` warmer adds `urls` (absolute or root-relative, one per line); the `sitemap` warmer adds `sitemaps` (sitemap URLs) and `minPriority` (only warm URLs at or above this `<priority>`). A response with status < 399 counts as a successful warm. Config lives under `warmer.settings:warmers.cdn` and `warmer.settings:warmers.sitemap`. Configure in the Warmer settings form at `/admin/config/development/warmer/settings`; warm with `drush warmer:enqueue cdn` or `drush warmer:enqueue sitemap`. No routes, permissions, services, or Drush of its own.

---

- Keep a CDN edge cache hot by periodically re-requesting your most important URLs
- Warm Varnish or Drupal's Page Cache even on sites without a CDN
- Warm every page listed in your XML sitemap automatically with the `sitemap` warmer
- Warm only high-priority sitemap URLs by setting `minPriority`
- Warm a hand-picked list of landing pages, campaign URLs, or API endpoints with the `cdn` warmer
- Send authentication or cache-buster headers with warming requests via `headers`
- Warm URLs behind self-signed certificates by turning off SSL `verify`
- Tune parallelism with `maxConcurrentRequests` to balance speed against server load
- Pre-warm pages immediately after a deploy: `drush warmer:enqueue cdn --run-queue`
- Warm relative URLs (e.g. `/about`) that resolve against the site's base URL
- Keep JSON:API or GraphQL responses warm by listing their URLs
- Warm multiple sitemaps (e.g. per-language sitemaps) in one `sitemap` warmer
- Schedule off-peak edge warming with a per-warmer `frequency` on cron
- Refresh anonymous page caches before their TTL expires to avoid cold-cache spikes
- Warm environment-specific URLs by pointing the URL list at a staging or prod base
- Warm a large sitemap in controlled batches using `batchSize`
- Reduce time-to-first-byte for anonymous visitors on key routes
- Warm image-style or asset URLs so first requests don't pay generation cost
- Combine with the entity warmer to warm both the entity cache and the rendered HTTP cache
