Memcache Admin is a submodule of Memcache that adds an administrative UI for monitoring the memcached daemons a Drupal site uses, including per-server and per-cluster statistics reports.

---

Running memcached in production is easier when you can see what it is doing. Memcache Admin adds statistics reports at `/admin/reports/memcache`, with drill-down pages per cluster, per server, and per statistics type, rendered by `MemcacheStatisticsController`. It gathers stats through event subscribers (`MemcacheServerStatsSubscriber`, `McrouterStatsSubscriber`) so it can report both plain memcached and mcrouter deployments, presenting figures like hit/miss ratios, item counts, memory usage, evictions, and uptime. A settings form at `/admin/config/system/memcache` (config `memcache_admin.settings`) has one option — `show_memcache_statistics` — to append a compact stats summary to the bottom of every page for quick debugging. Access is gated by two permissions: `access memcache statistics` for the reports, and the restricted `access slab cachedump` for dumping the contents of a memcache slab. It depends on the main `memcache` module and its configured servers. Use it to verify caching is effective, spot memory pressure, and troubleshoot cache behavior.

---

- View memcached statistics for all configured servers at `/admin/reports/memcache`.
- Drill into stats for a single cluster.
- Inspect raw statistics for one memcached server.
- View a specific statistics type (e.g. items, slabs) for a server.
- Check cache hit/miss ratios to confirm caching is effective.
- Monitor memory usage and evictions to detect undersized caches.
- Track uptime and current item counts of each daemon.
- Enable a per-page stats footer for quick debugging during development.
- Turn off the per-page stats footer in production via settings.
- Monitor an mcrouter-fronted memcache deployment.
- Dump the contents of a memcache slab (restricted permission) for deep debugging.
- Grant read-only stats access to ops staff without site-admin rights.
- Restrict slab cachedump to trusted administrators only.
- Verify that newly added memcached servers are reachable and serving.
- Diagnose why a cache bin is missing or thrashing.
- Compare load across servers in a memcached cluster.
- Confirm cache-tag invalidation isn't causing excessive flushes.
- Support capacity planning by watching memory headroom over time.
- Provide a quick health check page after a deploy or restart.
- Troubleshoot "object too large" or connection errors against live stats.
