Warmer is a framework for cache warming (cache pre-fetching): it enqueues items in batches and processes them so that expensive caches are already populated before a real visitor triggers them.

---

Warmer itself ships no warmers — it provides the plumbing: a `warmer` plugin type (`@Warmer` annotation, `plugin.manager.warmer` manager, `Plugin/warmer` discovery directory), a single `warmer.settings` config object that stores every warmer's `frequency` and `batchSize` (plus plugin-specific keys), a reliable `warmer` queue, a `hook_cron` that re-enqueues warmers whose `frequency` window has elapsed, and Drush commands (`warmer:enqueue`, `warmer:list`). Each warmer plugin implements `WarmerInterface` (usually by extending `WarmerPluginBase`): it builds batches of item IDs (`buildIdsBatch`), loads them (`loadMultiple`), and warms them (`warmMultiple`). Enqueued batches are stored as queue items and drained by the `warmer` queue worker on cron, or immediately when you pass `--run-queue`. Two submodules provide concrete warmers: `warmer_entity` (warms the entity cache for selected entity types/bundles) and `warmer_cdn` (issues HTTP GET requests to warm edge/Varnish/Page caches, either from an explicit URL list or from a sitemap). Configuration is done at `/admin/config/development/warmer/settings`; manual warming is triggered at `/admin/config/development/warmer` or via Drush. It has no permissions of its own — both routes are gated by `administer site configuration`.

---

- Pre-warm the render/page cache of your most important pages after every deployment so the first real visitor never hits a cold cache
- Keep Varnish or a CDN edge cache hot by periodically re-requesting key URLs before their TTL expires
- Warm the entity cache for a content type so entity loads are fast after a cache clear
- Run cache warming automatically on cron by setting a per-warmer `frequency`
- Trigger an immediate warm of specific warmers from the CLI in a deploy script: `drush warmer:enqueue cdn,entity --run-queue`
- Schedule warming (enqueue only) and let the normal `warmer` queue worker drain it during regular cron runs
- List every registered warmer plus its current frequency and batch size with `drush warmer:list`
- Tune throughput by adjusting a warmer's `batchSize` (items enqueued/processed per batch)
- Throttle warming frequency so a heavy warmer only re-runs at most once per configured interval
- Warm only published entities of a type using the Entity warmer's "published only" option
- Warm several entity-type/bundle pairs (e.g. `node:article`, `taxonomy_term:tags`) in one Entity warmer
- Warm a list of absolute or relative URLs through the CDN warmer with custom request headers
- Warm every URL listed in one or more XML sitemaps using the CDN via Sitemap warmer
- Filter sitemap URLs to warm by a minimum `<priority>` so only important pages are fetched
- Send custom HTTP headers (auth tokens, cache-buster headers) with warming requests
- Control SSL certificate verification and the number of concurrent HTTP requests the CDN warmer makes
- Build a custom warmer plugin for any expensive-to-compute cache (search index, computed field, external API response)
- Warm GraphQL/JSON:API responses by adding their URLs to the CDN warmer
- Reduce time-to-first-byte for anonymous traffic by keeping the Page Cache populated
- Smooth out load spikes after a full cache flush by re-warming in controlled batches instead of on-demand
- Combine with cron scheduling so warming happens off-peak rather than during traffic surges
- Programmatically enqueue and warm items from custom code via the `plugin.manager.warmer` and `warmer.queue_manager` services
- Integrate warming into CI/CD by calling the Drush command as a post-deploy step
- Warm caches for multiple environments by pointing the CDN warmer at environment-specific base URLs
- Ensure editorial previews are fast by warming recently edited content types
- Use the manual "Warm caches" form to force an ad-hoc warm without waiting for cron
