Cache Metrics records Drupal cache hits/misses and cache-tag invalidations over time and ships them to New Relic as custom events for analysis in New Relic Insights.

---

Cache Metrics is a lightweight, backend-only performance-telemetry module. It decorates Drupal's `cache_factory` service so that every cache `get()`/`getMultiple()` produces a `CacheGet` event (recording bin, cid, hit/miss, expiry, tags, URI and username), and it registers a cache-tags invalidator that produces an `InvalidateTag` event for every tag invalidation (recording tag, URI and username). Events are sent with the New Relic PHP extension's `newrelic_record_custom_event()` function, so they only fire when that extension is present. The module has no admin UI, routes, permissions, forms, or config entities — it is configured purely through container parameters (`cache_metrics.invalidations` and `cache_metrics.bins.blacklist`) defined in a `services.yml`. Both wrapper services are intended to be overridden so a different analytics backend can be substituted for New Relic. It is intended to run in Production (where New Relic is available) and to be left off in local/dev environments.

---

- Measure real cache hit/miss ratios per cache bin in a production Drupal site.
- Track cache-tag invalidation volume over time to find "chatty" tags such as `node_list`.
- Identify which URIs trigger the most cache-tag invalidations (e.g. `/node/add/<bundle>`, `/node/edit/<nid>`).
- Surface editorial activity patterns by graphing invalidations over time.
- Build a New Relic Insights dashboard of cache performance using the NRQL examples in the README.
- Compute overall "Cache Miss %" faceted by bin with NRQL against the `CacheGet` event.
- Graph "Cache Hit %" as a timeseries faceted by bin.
- Produce a pie chart of raw tag-invalidation counts faceted by tag.
- Correlate cache behavior with Acquia request IDs via the recorded `request_id` attribute.
- Correlate cache behavior with Cloudflare requests via the recorded `cf_ray` attribute.
- Attribute cache activity to the acting user via the recorded `username` attribute.
- Exclude high-volume, always-hit bins (`config`, `discovery` by default) from hit/miss logging to control event volume.
- Blacklist additional cache bins from hit/miss logging via the `cache_metrics.bins.blacklist` parameter.
- Fully disable cache hit/miss logging (while keeping invalidation logging) by setting the bin blacklist to `['*']`.
- Toggle cache-tag invalidation logging on or off via the `cache_metrics.invalidations` parameter.
- Enable the module only in the Production environment using environment-specific service files (see drupal.org/node/3079028).
- Adapt event volume to New Relic limits, relying on the New Relic daemon's automatic sampling for very busy sites.
- Swap New Relic for another analytics provider by overriding the `cache_metrics.cache_factory` service and its `CacheBackendWrapper`.
- Swap New Relic for another provider for invalidations by overriding the `cache_metrics.invalidator` service.
- Extend `CacheBackendWrapper` and override its `record()` method to send `CacheGet` data to a custom destination.
- Serve as a reference implementation of a `CacheFactoryInterface` decorator and a `cache_tags_invalidator`-tagged service.
- Keep per-request invalidation logging de-duplicated (each tag logged at most once per request unless re-invalidated).
- Monitor cache efficiency continuously without adding page-load latency, since New Relic buffers and flushes events asynchronously.
